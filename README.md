# Job Autopilot

Automated pipeline for job search, resume adaptation, PDF generation, and job application.

## Features
- Fetch jobs from Indeed based on keywords and location.
- Adapt resumes for AI screening (Talent Fit AI, ATS) using ChatGPT.
- Convert Markdown resumes to PDF.
- Automatically submit resumes via Selenium (example: Indeed).
- Logs and stores results for easy tracking.

---

## Installation & Setup

### Option 1: Using the full install script (recommended)

1. Download or copy the `install_project.sh` script.
2. Make it executable:

```bash
chmod +x install_project.sh
Run the script:

bash
Copy code
./install_project.sh
This will:

Clone the repository from GitHub.

Create and activate a virtual environment.

Install all required Python packages.

Copy config.py.example to config.py for configuration.

After installation, activate the environment (if not already active):

bash
Copy code
source venv/bin/activate
Option 2: Manual setup
Clone the repository:

bash
Copy code
git clone git@github.com:fobaty/job_autopilot.git
cd job_autopilot
Create a virtual environment:

bash
Copy code
python3 -m venv venv
Activate the virtual environment:

bash
Copy code
source venv/bin/activate
On Windows (PowerShell):

powershell
Copy code
venv\Scripts\Activate.ps1
Install dependencies:

bash
Copy code
pip install --upgrade pip
pip install -r requirements.txt
Create config.py from the example:

bash
Copy code
cp config.py.example config.py
Edit config.py to add your ChatGPT API key and other personal information.

Usage
Fetch jobs:

bash
Copy code
python fetch_jobs.py
Adapt resume for each job:

bash
Copy code
python adapt_resume.py
Convert adapted resumes to PDF:

bash
Copy code
python save_results.py
Apply to jobs automatically:

bash
Copy code
python apply_jobs.py
Notes
Test Selenium application on 1-2 vacancies before bulk submitting.

Adjust selectors in apply_jobs.py for different job boards.

Do not push config.py with API keys to GitHub.

Always activate the virtual environment when working on the project:

bash
Copy code
source venv/bin/activate
Requirements
Python 3.8+

Packages from requirements.txt

wkhtmltopdf installed on the system (for PDF generation)
