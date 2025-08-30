import json
import os
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from config import RESULTS_FOLDER, FULL_NAME, EMAIL

# Load adapted resumes
jobs = []
for file in os.listdir(RESULTS_FOLDER):
    if file.endswith(".pdf"):
        parts = file.replace(".pdf","").split("_")
        title = " ".join(parts[:-1])
        company = parts[-1]
        jobs.append({
            "title": title,
            "company": company,
            "resume_path": os.path.join(RESULTS_FOLDER, file)
        })

options = webdriver.ChromeOptions()
options.add_argument("--start-maximized")
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

def apply_to_job(job):
    print(f"Applying to {job['title']} at {job['company']}...")
    driver.get("https://www.indeed.com")  # Replace with actual job link

    try:
        upload_input = driver.find_element(By.XPATH, "//input[@type='file']")
        upload_input.send_keys(os.path.abspath(job['resume_path']))
        
        name_input = driver.find_element(By.XPATH, "//input[@name='name']")
        name_input.send_keys(FULL_NAME)
        
        email_input = driver.find_element(By.XPATH, "//input[@name='email']")
        email_input.send_keys(EMAIL)
        
        submit_button = driver.find_element(By.XPATH, "//button[contains(text(),'Submit')]")
        submit_button.click()
        
        print(f"Application submitted for {job['title']} at {job['company']}")
    except Exception as e:
        print(f"Failed to apply to {job['title']} at {job['company']}: {e}")

for job in jobs:
    apply_to_job(job)

driver.quit()
