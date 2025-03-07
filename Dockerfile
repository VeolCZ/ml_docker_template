ARG CUDA_VERSION=12.1.0
ARG BASE_IMAGE_TYPE=base
ARG OS_VERSION=ubuntu22.04

FROM nvidia/cuda:${CUDA_VERSION}-${BASE_IMAGE_TYPE}-${OS_VERSION}

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

RUN rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /app/data /app/logs
VOLUME /app /app/data /app/logs

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONFAULTHANDLER=1 \
    CUDA_CACHE_MAXSIZE=2147483647

CMD python3 main.py