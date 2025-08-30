import os
import markdown2
import pdfkit
from config import RESULTS_FOLDER

# Convert Markdown resumes to PDF
def convert_md_to_pdf():
    for file in os.listdir(RESULTS_FOLDER):
        if file.endswith(".md"):
            md_path = os.path.join(RESULTS_FOLDER, file)
            pdf_path = os.path.join(RESULTS_FOLDER, file.replace(".md", ".pdf"))
            
            with open(md_path) as f:
                html = markdown2.markdown(f.read())
            
            pdfkit.from_string(html, pdf_path)
            print(f"Converted {file} to PDF.")

if __name__ == "__main__":
    convert_md_to_pdf()
