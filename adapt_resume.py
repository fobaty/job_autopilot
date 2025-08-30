import openai
import json
import os
from config import CHATGPT_API_KEY, RESUME_TEMPLATE, RESULTS_FOLDER

openai.api_key = CHATGPT_API_KEY

with open("jobs_db.json") as f:
    jobs = json.load(f)

with open(RESUME_TEMPLATE) as f:
    resume_template = f.read()

os.makedirs(RESULTS_FOLDER, exist_ok=True)

def adapt_resume(job, resume):
    prompt = f"""
    Adapt the following resume to match this job posting for AI screening systems (like Talent Fit AI):
    Job Title: {job['title']}
    Company: {job['company']}
    Resume: {resume}

    Include keywords and skills from the job, quantify achievements, and structure resume in sections: Summary, Skills, Experience, Projects, Education.
    """
    response = openai.ChatCompletion.create(
        model="gpt-5-mini",
        messages=[{"role":"user","content":prompt}],
        temperature=0.3
    )
    return response['choices'][0]['message']['content']

for job in jobs:
    adapted_resume = adapt_resume(job, resume_template)
    filename = os.path.join(RESULTS_FOLDER, f"{job['title'].replace(' ','_')}_{job['company'].replace(' ','_')}.md")
    with open(filename, "w") as f:
        f.write(adapted_resume)
    print(f"Adapted resume saved for {job['title']} at {job['company']}")
