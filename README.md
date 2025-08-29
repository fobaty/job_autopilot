# Job Autopilot

Automated pipeline for job search, resume adaptation, and PDF generation.

## Features
- Fetch jobs from Indeed based on keywords and location.
- Adapt resumes for AI screening (Talent Fit AI, ATS) using ChatGPT.
- Convert Markdown resumes to PDF.
- Logs and stores results for easy tracking.

## Setup
1. Install dependencies:
```bash
pip install -r requirements.txt
Install wkhtmltopdf for PDF generation.

Set your ChatGPT API key in config.py.

Run:

bash
Copy code
python fetch_jobs.py
python adapt_resume.py
python save_results.py

## Automated Job Application
Run the apply script to automatically submit PDF resumes to job postings (example: Indeed):

```bash
python apply_jobs.py
