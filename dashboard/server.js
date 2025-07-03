const express = require('express');
const Docker = require('dockerode');
const { exec } = require('child_process');
const util = require('util');
const execPromise = util.promisify(exec);

const app = express();
const port = 3000;
const docker = new Docker();

// Serve static files
app.use(express.static('public'));

// Function to get container information and tokens
async function getContainerInfo() {
    try {
        const containers = await docker.listContainers({
            filters: {
                label: ['com.docker.compose.project=juno']
            }
        });

        const containerInfo = [];

        for (const containerData of containers) {
            const container = docker.getContainer(containerData.Id);
            const inspect = await container.inspect();
            
            // Extract container name and ports
            const name = inspect.Name.substring(1); // Remove leading slash
            const ports = inspect.NetworkSettings.Ports;
            
            let sshPort = null;
            let jupyterPort = null;
            
            for (const [containerPort, hostBindings] of Object.entries(ports)) {
                if (containerPort === '22/tcp' && hostBindings) {
                    sshPort = hostBindings[0].HostPort;
                }
                if (containerPort === '8888/tcp' && hostBindings) {
                    jupyterPort = hostBindings[0].HostPort;
                }
            }

            // Get JupyterLab token
            let token = null;
            try {
                const exec = await container.exec({
                    Cmd: ['python3', '-m', 'jupyterlab', 'list'],
                    AttachStdout: true,
                    AttachStderr: true,
                    User: 'eureka'
                });
                
                const stream = await exec.start();
                const output = await new Promise((resolve) => {
                    let data = '';
                    stream.on('data', (chunk) => {
                        data += chunk.toString();
                    });
                    stream.on('end', () => {
                        resolve(data);
                    });
                });

                const tokenMatch = output.match(/token=([a-f0-9]+)/);
                if (tokenMatch) {
                    token = tokenMatch[1];
                }
            } catch (error) {
                console.log(`Error getting token for ${name}:`, error.message);
            }

            containerInfo.push({
                name,
                status: inspect.State.Status,
                sshPort,
                jupyterPort,
                token,
                hostname: name.toLowerCase()
            });
        }

        return containerInfo;
    } catch (error) {
        console.error('Error getting container info:', error);
        return [];
    }
}

// API endpoint to get container information
app.get('/api/containers', async (req, res) => {
    const containers = await getContainerInfo();
    res.json(containers);
});

// Main dashboard route
app.get('/', (req, res) => {
    res.send(`
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Juno Dashboard - JupyterLab Learning Environment</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(45deg, #2c3e50, #34495e);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        
        .header p {
            font-size: 1.1em;
            opacity: 0.9;
        }
        
        .content {
            padding: 30px;
        }
        
        .loading {
            text-align: center;
            padding: 50px;
            font-size: 1.2em;
            color: #666;
        }
        
        .container-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        
        .container-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 25px;
            border-left: 5px solid #3498db;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .container-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .container-name {
            font-size: 1.5em;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .status-indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 10px;
        }
        
        .status-running {
            background-color: #27ae60;
            box-shadow: 0 0 10px rgba(39, 174, 96, 0.5);
        }
        
        .status-stopped {
            background-color: #e74c3c;
        }
        
        .container-info {
            margin-bottom: 20px;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            padding: 5px 0;
        }
        
        .info-label {
            font-weight: 600;
            color: #666;
        }
        
        .info-value {
            color: #2c3e50;
            font-family: 'Courier New', monospace;
        }
        
        .jupyter-link {
            display: inline-block;
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            transition: all 0.3s ease;
            text-align: center;
            width: 100%;
        }
        
        .jupyter-link:hover {
            background: linear-gradient(45deg, #c0392b, #a93226);
            transform: scale(1.05);
        }
        
        .jupyter-link.disabled {
            background: #95a5a6;
            cursor: not-allowed;
            pointer-events: none;
        }
        
        .ssh-info {
            background: #ecf0f1;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
        }
        
        .ssh-command {
            font-family: 'Courier New', monospace;
            background: #34495e;
            color: #ecf0f1;
            padding: 10px;
            border-radius: 5px;
            margin-top: 8px;
            word-break: break-all;
        }
        
        .refresh-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: #3498db;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 50%;
            font-size: 1.2em;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
            transition: all 0.3s ease;
        }
        
        .refresh-btn:hover {
            background: #2980b9;
            transform: scale(1.1);
        }
        
        @media (max-width: 768px) {
            .container-grid {
                grid-template-columns: 1fr;
            }
            
            .header h1 {
                font-size: 2em;
            }
            
            .container {
                margin: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Juno Dashboard</h1>
            <p>JupyterLab Learning Environment - Access Portal</p>
        </div>
        <div class="content">
            <div id="loading" class="loading">
                Loading containers...
            </div>
            <div id="containers" class="container-grid" style="display: none;"></div>
        </div>
    </div>
    
    <button class="refresh-btn" onclick="loadContainers()" title="Refresh">
        🔄
    </button>

    <script>
        let serverHost = window.location.hostname;
        
        async function loadContainers() {
            const loadingEl = document.getElementById('loading');
            const containersEl = document.getElementById('containers');
            
            loadingEl.style.display = 'block';
            containersEl.style.display = 'none';
            
            try {
                const response = await fetch('/api/containers');
                const containers = await response.json();
                
                if (containers.length === 0) {
                    loadingEl.innerHTML = 'No containers found. Make sure the Juno environment is running.';
                    return;
                }
                
                containersEl.innerHTML = containers.map(container => {
                    const jupyterUrl = container.token ? 
                        \`http://\${serverHost}:\${container.jupyterPort}/lab?token=\${container.token}\` : 
                        '#';
                    
                    const sshCommand = \`ssh eureka@\${serverHost} -p \${container.sshPort}\`;
                    
                    return \`
                        <div class="container-card">
                            <div class="container-name">
                                <div class="status-indicator \${container.status === 'running' ? 'status-running' : 'status-stopped'}"></div>
                                \${container.name}
                            </div>
                            
                            <div class="container-info">
                                <div class="info-row">
                                    <span class="info-label">Status:</span>
                                    <span class="info-value">\${container.status}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">SSH Port:</span>
                                    <span class="info-value">\${container.sshPort}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Jupyter Port:</span>
                                    <span class="info-value">\${container.jupyterPort}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Token:</span>
                                    <span class="info-value">\${container.token ? container.token.substring(0, 8) + '...' : 'Not available'}</span>
                                </div>
                            </div>
                            
                            <a href="\${jupyterUrl}" target="_blank" class="jupyter-link \${!container.token ? 'disabled' : ''}">
                                \${container.token ? '📚 Open JupyterLab' : 'JupyterLab not ready'}
                            </a>
                            
                            <div class="ssh-info">
                                <strong>SSH Access:</strong>
                                <div class="ssh-command">\${sshCommand}</div>
                                <small style="color: #666; margin-top: 5px; display: block;">Default password: 3Ur3k4</small>
                            </div>
                        </div>
                    \`;
                }).join('');
                
                loadingEl.style.display = 'none';
                containersEl.style.display = 'grid';
                
            } catch (error) {
                console.error('Error loading containers:', error);
                loadingEl.innerHTML = 'Error loading containers. Please check if the server is running.';
            }
        }
        
        // Load containers on page load
        loadContainers();
        
        // Auto-refresh every 30 seconds
        setInterval(loadContainers, 30000);
    </script>
</body>
</html>
    `);
});

app.listen(port, '0.0.0.0', () => {
    console.log(`Juno Dashboard running at http://localhost:${port}`);
});
