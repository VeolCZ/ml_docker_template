ARG CUDA_VERSION=12.1.0
ARG BASE_IMAGE_TYPE=base
ARG OS_VERSION=ubuntu22.04

FROM nvidia/cuda:${CUDA_VERSION}-${BASE_IMAGE_TYPE}-${OS_VERSION}

RUN mkdir -p /data /logs

COPY requirements.txt .

VOLUME /app /data /logs

WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    software-properties-common \
    build-essential \
    libatlas-base-dev \
    gfortran \
    libopenblas-dev

RUN pip install --no-cache-dir -r requirements.txt && rm -rf /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONFAULTHANDLER=1

CMD ["python3", "main.py"]