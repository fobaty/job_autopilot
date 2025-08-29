#!/bin/bash

# ===============================
# Job Autopilot Full Install Script
# ===============================

# Variables
REPO_SSH="git@github.com:fobaty/job_autopilot.git"
PROJECT_DIR="$HOME/job_autopilot"

echo "=== Job Autopilot Full Install Script ==="

# 1. Check Python
if ! command -v python3 &> /dev/null
then
    echo "Python3 not found. Please install Python 3.8+"
    return 1 2>/dev/null || exit 1
fi

# 2. Clone repository
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Cloning repository..."
    git clone "$REPO_SSH" "$PROJECT_DIR"
else
    echo "Directory $PROJECT_DIR already exists. Pulling latest changes..."
    cd "$PROJECT_DIR" || return
    git pull origin main
fi

# 3. Enter project directory
cd "$PROJECT_DIR" || return

# 4. Create virtual environment
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
else
    echo "Virtual environment already exists."
fi

# 5. Try to activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate 2>/dev/null

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

# 9. Check if virtual environment is active
if [[ "$(which python)" == *"$PROJECT_DIR/venv/bin/python"* ]]; then
    echo "✅ Virtual environment is active."
    echo "You are now inside $PROJECT_DIR"
else
    echo "⚠️ Virtual environment is NOT active."
    echo "Please run the following command to activate it manually:"
    echo "   source $PROJECT_DIR/venv/bin/activate"
fi

echo "=== Installation completed! ==="
echo "You can run scripts: fetch_jobs.py, adapt_resume.py, save_results.py, apply_jobs.py"
