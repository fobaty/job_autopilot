# Job Autopilot

Automated pipeline for job search, resume adaptation, PDF generation, and job application.

## Features
- Fetch jobs from Indeed based on keywords and location.
- Adapt resumes for AI screening (Talent Fit AI, ATS) using ChatGPT.
- Convert Markdown resumes to PDF.
- Automatically submit resumes via Selenium (example: Indeed).
- Logs and stores results for easy tracking.

---

##  Installation & Setup .
###  Option 1: Quick Installation (recommended).

Copy and run the following command in your terminal:
```bash
curl -fsSL https://raw.githubusercontent.com/fobaty/job_autopilot/main/install_project.sh -o install_project.sh && source install_project.sh
```

This command will download and execute the install_project.sh script, which automatically installs the project and all required dependencies.

### Option 2: Using the full install script 

1. Download or copy the `install_project.sh` script.
```bash
  curl -fsSL -o install_project.sh https://raw.githubusercontent.com/fobaty/job_autopilot/main/install_project.sh
```
2. Make it executable:

```bash
chmod +x install_project.sh
 ```
3. Run the script:

```bash
./install_project.sh
 ```
This will:

Clone the repository from GitHub.

Create and activate a virtual environment.

Install all required Python packages.

Copy config.py.example to config.py for configuration.

4. After installation, activate the environment (if not already active):

```bash
source venv/bin/activate
 ```
###  Option 3: Manual setup
1. Clone the repository:

```bash
git clone git@github.com:fobaty/job_autopilot.git
cd job_autopilot
 ```
2. Create a virtual environment:

```bash
python3 -m venv venv
```
3. Activate the virtual environment:
 
```bash
source venv/bin/activate
```
On Windows (PowerShell):

powershell
```bash
venv\Scripts\Activate.ps1
```
4. Install dependencies:

```bash
pip install --upgrade pip
pip install -r requirements.txt
```
5. Create config.py from the example:

```bash
cp config.py.example config.py
```
Edit config.py to add your ChatGPT API key and other personal information.

## Usage
1. Fetch jobs:

```bash
python fetch_jobs.py
```
2. Adapt resume for each job:

```bash
python adapt_resume.py
```
3. Convert adapted resumes to PDF:

```bash
python save_results.py
```
4. Apply to jobs automatically:

```bash
python apply_jobs.py
```
## Notes
Test Selenium application on 1-2 vacancies before bulk submitting.

Adjust selectors in apply_jobs.py for different job boards.

Do not push config.py with API keys to GitHub.

Always activate the virtual environment when working on the project:

```bash
source venv/bin/activate
```
## Requirements
Python 3.8+

Packages from requirements.txt

wkhtmltopdf installed on the system (for PDF generation)
