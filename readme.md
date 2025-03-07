## Python GPU Project Template

This repository provides a reusable Docker-based template for Python projects that leverage NVIDIA CUDA GPUs. It includes optimizations for performance, a flexible build system using environment variables, and scripts for building and managing containers. The template supports mounting directories for code, data, and logs, making it suitable for machine learning, scientific computing, or any GPU-accelerated workload.

#### Prerequisites

    Docker: Installed and running.
    Docker Compose: Installed (typically included with Docker Desktop).
    NVIDIA GPU: With compatible drivers installed.
    NVIDIA Container Toolkit: Installed for GPU support in Docker (see installation guide).

#### Setup

Clone the Repository:
```bash
    git clone <repository-url>
    cd <repository-directory>
```

Configure the .env File: Edit .env to set your project details:
text
- PROJECT_NAME=my-python-project   # Name of your project/container
- CUDA_VERSION=12.1.0              # CUDA version (e.g., 11.8.0, 12.1.0)
- BASE_IMAGE_TYPE=base             # Image type (base, devel, runtime)
- OS_VERSION=ubuntu22.04           # Base OS version (ubuntu20.04, ubuntu22.04)

Add Dependencies: List your Python packages in requirements.txt. Example:
```text
    torch
    numpy
    scipy
    Place Your Code: Add your Python scripts (e.g., main.py) to the app/ directory.
```

#### Usage
Build the Docker image using the build.sh script:
```bash
./build.sh
```

Start the Container
```bash
docker-compose up
```

Stop the Container
```bash
docker-compose down
```

#### Project Structure

project_root/
├── .env               # Environment variables (project name, CUDA version, etc.)
├── Dockerfile         # Docker image definition with GPU and Python optimizations
├── docker-compose.yml # Service configuration for GPU access and volume mounts
├── build.sh           # Script to build the container
├── requirements.txt   # Python dependencies
├── app/               # Application code directory
│   └── main.py        # Main Python script (example health check code)
├── data/              # Persistent data directory (created at runtime)
└── logs/              # Persistent logs directory (created at runtime)

#### License

This template is provided under the MIT License. Feel free to modify and distribute as needed.