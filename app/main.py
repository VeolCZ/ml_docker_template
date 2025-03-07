#!/usr/bin/env python3
import os
import sys
import torch
import multiprocessing
import numpy as np

# This program simply tests that your setup is healthy
# If the output matches your machine feel free to delete and start programming!

def check_compute():
    """Check GPU and CPU availability and properties."""
    cpu_count = multiprocessing.cpu_count()
    print(f"CPU Cores Available: {cpu_count}")

    gpu_available = torch.cuda.is_available()
    print(f"GPU Available: {gpu_available}")

    if gpu_available:
        gpu_count = torch.cuda.device_count()
        print(f"Number of GPUs: {gpu_count}")
        for i in range(gpu_count):
            gpu_name = torch.cuda.get_device_name(i)
            gpu_memory = torch.cuda.get_device_properties(i).total_memory / (
                1024**3
            )  # GB
            print(f"GPU {i}: {gpu_name}, Memory: {gpu_memory:.2f} GB")
        current_device = torch.cuda.current_device()
        print(f"Current GPU Device: {current_device}")
    else:
        print("Error: No GPU detected. Check NVIDIA drivers and runtime.")


def check_environment():
    """Check key environment variables and setup."""
    print("\nEnvironment Checks:")
    for var in ["PYTHONUNBUFFERED", "PYTHONDONTWRITEBYTECODE", "CUDA_CACHE_MAXSIZE"]:
        value = os.getenv(var, "Not set")
        print(f"{var}: {value}")

    for path in ["/app", "/app/data", "/app/logs"]:
        writable = os.access(path, os.W_OK)
        print(f"{path} writable: {writable}")
        if not writable:
            print(f"Error: {path} is not writable. Check volume mounts.")


def main():
    print("Running Docker Health Check...\n")
    check_compute()
    check_environment()

    if not torch.cuda.is_available() or not all(
        os.access(p, os.W_OK) for p in ["/app", "/app/data", "/app/logs"]
    ):
        print("\nHealth Check Failed!")
        sys.exit(1)

    print("\nHealth Check Passed!")
    sys.exit(0)


if __name__ == "__main__":
    main()
