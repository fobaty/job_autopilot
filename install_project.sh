#!/bin/bash

# ===============================
# Job Autopilot Full Install Script
# ===============================

# Variables
REPO_SSH="git@github.com:fobaty/job_autopilot.git"
PROJECT_DIR="job_autopilot"

echo "=== Job Autopilot Full Install Script ==="

# 1. Check Python
if ! command -v python3 &> /dev/null
then
    echo "Python3 not found. Please install Python 3.8+"
    exit 1
fi

# 2. Clone repository
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Cloning repository..."
    git clone "$REPO_SSH"
else
    echo "Directory $PROJECT_DIR already exists. Pulling latest changes..."
    cd "$PROJECT_DIR"
    git pull origin main
    cd ..
fi

# 3. Enter project directory
cd "$PROJECT_DIR" || exit

# 4. Create virtual environment
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
else
    echo "Virtual environment already exists."
fi

# 5. Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# 6. Upgrade pip
pip install --upgrade pip

# 7. Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# 8. Create config.py if it doesn't exist
if [ ! -f config.py ]; then
    cp config.py.example config.py
    echo "config.py created from example. Edit it to add your API key and personal info."
else
    echo "config.py already exists. Skipping."
fi

echo "=== Installation completed! ==="
echo "Activate the environment using: source venv/bin/activate"
echo "Then run scripts: fetch_jobs.py, adapt_resume.py, save_results.py, apply_jobs.py"
