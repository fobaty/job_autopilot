import requests
from bs4 import BeautifulSoup
import json
from config import JOB_KEYWORDS, JOB_LOCATION

# Fetch jobs from Indeed based on keywords and location
def fetch_indeed_jobs():
    jobs = []
    for keyword in JOB_KEYWORDS:
        url = f"https://www.indeed.com/jobs?q={keyword.replace(' ','+')}&l={JOB_LOCATION.replace(' ','+')}"
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')

        for div in soup.find_all('div', class_='job_seen_beacon'):
            title = div.find('h2').text.strip() if div.find('h2') else "No Title"
            company = div.find('span', class_='companyName').text.strip() if div.find('span', class_='companyName') else "No Company"
            link_tag = div.find('a', href=True)
            link = "https://www.indeed.com" + link_tag['href'] if link_tag else ""
            
            jobs.append({
                "title": title,
                "company": company,
                "link": link,
                "keyword": keyword
            })
    with open("jobs_db.json", "w") as f:
        json.dump(jobs, f, indent=2)
    return jobs

if __name__ == "__main__":
    jobs = fetch_indeed_jobs()
    print(f"Fetched {len(jobs)} jobs from Indeed.")
