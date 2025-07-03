# Contributing to Juno

We welcome contributions to the Juno project! This document provides guidelines and information about contributing to our JupyterLab-based STEM learning environment.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Environment](#development-environment)
- [Commit Guidelines](#commit-guidelines)
- [Documentation Standards](#documentation-standards)
- [Testing and Quality](#testing-and-quality)
- [Pull Request Process](#pull-request-process)
- [Project Structure](#project-structure)
- [Issue Reporting](#issue-reporting)
- [Code of Conduct](#code-of-conduct)

## Getting Started

1. Fork the project on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/your-username/Juno.git
   cd Juno
   ```
3. Create a branch for your contribution:
   ```bash
   git checkout -b feature/new-feature
   ```
4. Make your changes following the guidelines below
5. Test your changes thoroughly
6. Commit your changes with proper commit messages
7. Push your changes to your repository:
   ```bash
   git push origin feature/new-feature
   ```
8. Open a pull request on GitHub

## Development Environment

### Prerequisites

Before contributing, ensure your system meets these requirements:

- **Docker Engine** (24.0+) running on a modern Linux distribution
- **Docker Compose** (v2.21+) for container orchestration
- **Python 3** (3.13+) for running generator scripts
- **Node.js and npm** (for dashboard development)

### Supported Distributions

- Ubuntu 24.04 LTS / Debian 12
- Fedora 40+ / RHEL 9+ / CentOS Stream 9+

### Installation

Refer to the main [README.md](README.md) for detailed installation instructions for your distribution.

### Container Management

This project uses Docker and Docker Compose for container orchestration. All container operations are handled through Docker Compose commands and the provided management scripts.

### Setting Up Development Environment

1. **Generate containers configuration**:
   ```bash
   ./generator.py
   ```

2. **Build and start containers**:
   ```bash
   ./build.sh -b
   ```

3. **Start the dashboard** (optional but recommended):
   ```bash
   ./dashboard.sh
   ```

## Commit Guidelines

We follow conventional commit standards to maintain a clear and consistent commit history.

### Commit Format

```
<type>: <description>

[optional body]

[optional footer]
```

### Commit Types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, etc.)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools and libraries
- **ci**: Changes to CI configuration files and scripts

### Examples

```bash
# Good commits
git commit -m "feat: add dashboard auto-refresh functionality"
git commit -m "fix: resolve container port conflict issue"
git commit -m "docs: update installation instructions for Fedora"
git commit -m "chore: update Python dependencies"

# Avoid
git commit -m "🚀 Add new feature"  # No emojis
git commit -m "Agregar nueva funcionalidad"  # Use English
git commit -m "WIP stuff"  # Be descriptive
```

### Changelog Updates

**Important**: When making significant changes that affect users, update the [CHANGELOG.md](CHANGELOG.md) file following the [Keep a Changelog](https://keepachangelog.com/) format.

## Documentation Standards

### Language Requirements

All Markdown documentation must be written in **International English**. This ensures accessibility for the global community.

### Markdown Style Guide

For detailed Markdown formatting guidelines, please refer to our comprehensive [Markdown Standards](MARKDOWN_STANDARDS.md) document.

#### Key Requirements

- Use ATX-style headers (`#`, `##`, `###`) with spaces after `#`
- Use `-` for unordered lists, `1.` for ordered lists
- Always specify language for code blocks: ````bash`, ````python`, etc.
- Use descriptive link text and relative paths for internal links
- Include alt text for all images
- Use backticks for file names and inline code: `README.md`
- Follow consistent formatting for emphasis and structure

## Testing and Quality

### Before Submitting

1. **Test container generation**:
   ```bash
   ./generator.py
   docker compose config  # Validate generated compose.yaml
   ```

2. **Test container deployment**:
   ```bash
   ./build.sh -b
   docker ps  # Verify containers are running
   ```

3. **Test dashboard functionality** (if applicable):
   ```bash
   ./dashboard.sh
   # Access http://localhost:3000 and verify functionality
   ```

4. **Validate documentation**:
   - Check for spelling and grammar
   - Ensure all links work correctly
   - Verify code examples are accurate

### Code Quality

- Follow existing code patterns and conventions
- Comment complex logic appropriately
- Ensure scripts are executable and have proper shebangs
- Test scripts on supported distributions when possible

## Pull Request Process

### Before Creating a PR

1. Ensure your branch is up to date with the main branch
2. Test your changes thoroughly
3. Update documentation if necessary
4. Update CHANGELOG.md for significant changes

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Other (specify)

## Testing
- [ ] Tested on Ubuntu/Debian
- [ ] Tested on Fedora/RHEL
- [ ] Container generation works
- [ ] Dashboard functionality verified
- [ ] Documentation updated

## Checklist
- [ ] Commits follow conventional format
- [ ] Documentation is in English
- [ ] CHANGELOG.md updated (if applicable)
- [ ] No breaking changes (or clearly documented)
```

### Review Process

1. All PRs require at least one review
2. Maintain backwards compatibility unless breaking changes are necessary
3. Address feedback promptly and professionally
4. Ensure CI checks pass before merging

## Project Structure

### Key Directories

```
Juno/
├── .assets/          # Project assets and diagrams
├── app/              # Container application files
│   ├── etc/          # SSH configuration
│   ├── home/         # User home directory setup
│   └── notes/        # Jupyter notebooks and lessons
├── dashboard/        # Web dashboard source code
├── build.sh          # Container management script
├── generator.py      # Compose file generator
├── dashboard.sh      # Dashboard setup script
└── docs/             # Additional documentation (if added)
```

### File Naming Conventions

- Use lowercase with hyphens for directories: `new-feature/`
- Use descriptive names for scripts: `container-manager.sh`
- Follow existing patterns in the project

### Where to Add New Files

- **Scripts**: Root directory (with appropriate permissions)
- **Documentation**: Root directory or `docs/` (if created)
- **Container configs**: `app/` directory
- **Web assets**: `dashboard/` directory
- **Project assets**: `.assets/` directory

## Issue Reporting

### Bug Reports

When reporting bugs, please include:

- **Environment**: OS, Docker version, distribution
- **Steps to reproduce**: Clear, numbered steps
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Logs**: Relevant error messages or logs
- **Additional context**: Screenshots, configurations, etc.

### Feature Requests

For feature requests, please provide:

- **Use case**: Why is this feature needed?
- **Proposed solution**: How should it work?
- **Alternatives**: Other solutions considered
- **Additional context**: Examples, mockups, etc.

## Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to incognia@gmail.com.

## Questions?

If you have questions about contributing, feel free to:

- Open an issue for discussion
- Check existing issues and documentation
- Contact the maintainers

Thank you for contributing to Juno! 🚀
