#!/bin/bash

# ===============================
# Job Autopilot Full Install Script
# ===============================

# Variables
REPO_HTTPS="https://github.com/fobaty/job_autopilot.git"  # HTTPS для удобства
PROJECT_DIR="$HOME/job_autopilot"  # абсолютный путь, чтобы cd точно работал

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
    git clone "$REPO_HTTPS" "$PROJECT_DIR"
else
    echo "Directory $PROJECT_DIR already exists. Pulling latest changes..."
    cd "$PROJECT_DIR" || exit 1
    git pull origin main
fi

# 3. Enter project directory
cd "$PROJECT_DIR" || exit 1

# 4. Create virtual environment
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
else
    echo "Virtual environment already exists."
fi

# 5. Try to activate virtual environment (только внутри скрипта)
echo "Activating virtual environment (temporary, inside script)..."
source venv/bin/activate 2>/dev/null || true

# 6. Upgrade pip
pip install --upgrade pip

# 7. Install dependencies
if [ -f requirements.txt ]; then
    echo "Installing dependencies..."
    pip install -r requirements.txt
else
    echo "⚠️ requirements.txt not found, skipping."
fi

# 8. Create config.py if it doesn't exist
if [ ! -f config.py ]; then
    if [ -f config.py.example ]; then
        cp config.py.example config.py
        echo "config.py created from example. Edit it to add your API key and personal info."
    else
        echo "⚠️ config.py.example not found, please create config.py manually."
    fi
else
    echo "config.py already exists. Skipping."
fi

# 9. Final instructions
echo "=== Installation completed! ==="
if [ -n "$VIRTUAL_ENV" ]; then
    echo "✅ Virtual environment is active (because you ran the script with 'source')."
    echo "You are now inside $PROJECT_DIR"
else
    echo "⚠️ Virtual environment is NOT active after script exit."
    echo "👉 To activate it, run:"
    echo "   cd $PROJECT_DIR"
    echo "   source venv/bin/activate"
fi

echo "You can then run scripts: fetch_jobs.py, adapt_resume.py, save_results.py, apply_jobs.py"
