#!/bin/bash

if [ -z "$RUN_MODE" ] || [ "$RUN_MODE" == "script" ]; then
    echo "Running Python script..."
    exec python3 main.py
else
    echo "Starting Jupyter Notebook..."
    exec jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''
fi