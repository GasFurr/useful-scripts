#!/bin/bash

# Path to the OpenSeeFace directory
OPENSEEFACE_DIR="$HOME/OpenSeeFace"

# Check if the directory exists
if [ ! -d "$OPENSEEFACE_DIR" ]; then
    echo "Error: OpenSeeFace directory not found at $OPENSEEFACE_DIR"
    exit 1
fi

# Navigate to the OpenSeeFace directory
cd "$OPENSEEFACE_DIR" || exit 1

# Activate the Python virtual environment
if [ -f "env/bin/activate" ]; then
    source "env/bin/activate"
else
    echo "Error: Virtual environment not found in $OPENSEEFACE_DIR/env"
    exit 1
fi

# Run the facetracker with the specified parameters
python "$OPENSEEFACE_DIR/facetracker.py" -c 0 -W 1280 -H 720 \
    --discard-after 0 \
    --scan-every 0 \
    --no-3d-adapt 1 \
    --max-feature-updates 900
