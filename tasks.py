from invoke import task
from pathlib import Path
import os
import shutil

os.environ["PYTHONIOENCODING"] = "utf-8"

@task
def clean(c):
    print("Cleaning docs...")
    for item in Path("docs").iterdir():
        if item.is_file() or item.is_symlink():
            item.unlink()
        elif item.is_dir():
            shutil.rmtree(item)

@task
def css(c):
    print("Creating docs/styles.css...")
    shutil.copy('styles.css', 'docs')

@task
def labs(c):
    print("Creating docs/labs...")
    Path("docs/labs").mkdir(parents=True, exist_ok=True)
    path = Path('labs')
    lab_dirs = [f for f in path.iterdir() if f.is_dir()]
    for curr_dir in lab_dirs:
        for typst_lab in curr_dir.glob('*.typ'):
            pdf_lab = 'docs/labs/' + typst_lab.stem + '.pdf'
            c.run(f'typst compile --root . {typst_lab} {pdf_lab}', echo=True, encoding='utf-8')
            html_lab = 'docs/labs/' + typst_lab.stem + '.html'
            c.run(f'typst compile --root . --features html --format html {typst_lab} {html_lab}', echo=True, encoding='utf-8')

@task
def slides(c):
    print("Creating docs/slides...")
    Path("docs/slides").mkdir(parents=True, exist_ok=True)
    path = Path('slides')
    for typst_slides in path.glob('*.typ'):
        pdf_slides = 'docs/slides/' + typst_slides.stem + '.pdf'
        c.run(f'typst compile --root . {typst_slides} {pdf_slides}', echo=True, encoding='utf-8')

@task
def syllabus(c):
    print("Creating docs/syllabus.pdf...")
    c.run('typst compile --root . syllabus.typ docs/syllabus.pdf', echo=True, encoding='utf-8')

@task
def project(c):
    print("Creating docs/project.pdf...")
    c.run('typst compile --root . project.typ docs/project.pdf', echo=True, encoding='utf-8')
    print(f"Creating docs/project.html...")
    c.run(f'typst compile --root . --features html --format html project.typ docs/project.html', echo=True, encoding='utf-8')

@task(
    pre=[clean, css, labs, slides, syllabus, project],
)
def all(c):
    print("Rebuilding everything...")
