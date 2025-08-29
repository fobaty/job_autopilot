#!/bin/bash

# ===============================
# Job Autopilot Full Install Script
# ===============================

# 1. Determine the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR/job_autopilot"

# Repository URL (HTTPS)
REPO_HTTPS="https://github.com/fobaty/job_autopilot.git"

echo "=== Job Autopilot Full Install Script ==="

# 2. Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 not found. Please install Python 3.8+"
    return 1 2>/dev/null || exit 1
fi

# 3. Clone the repository if it doesn't exist, otherwise pull latest changes
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Cloning repository into $PROJECT_DIR..."
    git clone "$REPO_HTTPS" "$PROJECT_DIR"
else
    echo "Directory $PROJECT_DIR already exists. Pulling latest changes..."
    cd "$PROJECT_DIR" || exit 1
    git pull origin main
fi

# 4. Enter the project directory
cd "$PROJECT_DIR" || exit 1
echo "📂 Changed directory to $PROJECT_DIR"

# 5. Create a Python virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
else
    echo "Virtual environment already exists."
fi

# 6. Temporarily activate the virtual environment for installing dependencies
source venv/bin/activate 2>/dev/null || true

# 7. Upgrade pip
pip install --upgrade pip

# 8. Install project dependencies from requirements.txt
if [ -f requirements.txt ]; then
    echo "Installing dependencies..."
    pip install -r requirements.txt
else
    echo "⚠️ requirements.txt not found, skipping."
fi

# 9. Create config.py from example if it doesn't exist
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

# 10. Final instructions to the user
echo ""
echo "=== Installation completed! ==="
echo ""
echo "📌 To start using Job Autopilot:"
echo "   1. Make sure you are in the project directory:"
echo "      cd $PROJECT_DIR"
echo "   2. Activate the virtual environment:"
echo "      source venv/bin/activate"
echo ""
echo "After that you can run scripts:"
echo "   fetch_jobs.py, adapt_resume.py, save_results.py, apply_jobs.py"
