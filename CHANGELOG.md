# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Updated Python base image from 3.11.6 to 3.13.5
- Updated JupyterLab from 4.0.6 to 4.4.4
- Updated Docker Compose version from 3.8 to 3.9
- Updated Docker image version tag from 0.0.1 to 0.0.2
- Updated README.md badges to reflect new versions

### Technical Details
- Dockerfile now uses `python:3.13.5-slim-bookworm` as base image
- JupyterLab installation now pins to version 4.4.4 for consistency
- Generator script updated to use new compose version and image tag
- Build script updated to reference new image version
- All configuration files regenerated with updated versions

## [0.0.1] - 2023-09-14

### Added
- Initial release of Juno JupyterLab-based STEM learning environment
- Docker containerization with Python 3.11.6 and JupyterLab 4.0.6
- Multi-container support for classroom deployment
- SSH access with individual port mapping
- Volume persistence for student work and SSH configurations
- Automated container generation via Python script
- Spanish language pack for JupyterLab
- Comprehensive documentation and setup guides
- Integration with "Learn Python with Jupyter" curriculum
- Management scripts for deployment and maintenance

### Features
- Automated Docker Compose file generation
- Individual student environments with isolated containers
- Persistent volumes for homework and configuration retention
- Easy lesson distribution system
- Port management for SSH (1022+) and JupyterLab (1088+)
- User management with default credentials
- Pre-configured development environment with common tools

### Documentation
- Complete setup and deployment guide
- Student access instructions
- Container management documentation
- Volume persistence explanation
- Acknowledgments to source materials and contributors

[Unreleased]: https://github.com/incognia/Juno/compare/v0.0.1...HEAD
[0.0.1]: https://github.com/incognia/Juno/releases/tag/v0.0.1
