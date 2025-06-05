# SYS
sys.argv  // returns an array of args plus orig command as first item

# WEB BROWSER
webbrowswer.open(url)

# PYPERCLIP
pyperclip.paste()

# REQUESTS
res = requests.get(url)
res.status_code
res.text  // gives you all the text in a string

res.raise_for_status()  // raises an error if bad request is returned
res.iter_content(10000)  // returns an iterable to loop over with a specified chunk size in bytes
    for chunk in res.iter_content(100000)
        file.write(chunk)

# BEAUTIFUL SOUP
import bs4
soup = bs4.BeautifulSoup(res.text)
elem = soup.select('css-selector')  // right click element select 'Copy CSS Path' in the browser
elem[0].text.strip()


# SELENIUM
from selenium import webdriver
browser = webdriver.Firefox()
browser.get(url)
browser.back()
browser.forward()
browser.quit()
browser.refresh()

elem = browser.find_element_by_css_selector(selector)
elem.text
elem.click()
elem.send_keys('text to type in browser')  // used to type in the browser forms
elem.submit()  // finds submit button associated with form element


# OPENPYXL 
import openpyxl
workbook = openpyxl.load_workbook(file)
sheet = workbook.get_sheet_by_name(name)
cell = sheet['A1']
cell.value


# SMTP LIB
import smtplib
conn = smtplib.SMTP(host, port)  // port is usually 587
conn.ehlo()  // connect to server
conn.starttls()  // begins encryption
conn.login(user, pw)
conn.sendmail(from, to, email_body)  // return a dict of failed emails
body = 'subject: whatever \n\n   // double new line ends headers
        body starts here. some text'
conn.quit()

# UV
```bash
# 🔧 Install uv
curl -Ls https://astral.sh/uv/install.sh | sh

# 🛠 Basic Package Management
# Install a package
uv pip install <package>
uv pip install -r requirements.txt
uv pip uninstall <package>
uv pip freeze

# 🧪 Virtual Environment Management
# Using the run command creates venv automatically
# Create a new virtual environment in a directory
uv venv <dir>
uv venv --python=python3.11 <dir>
# ✅ NOTE: You do NOT need to activate the venv manually!
# uv run and uv pip automatically use the .venv

# 🔁 Dependency Syncing
# Sync the environment to match uv.lock exactly
uv pip sync
# Add a new dependency (updates pyproject.toml + uv.lock)
uv pip add <package>
uv pip remove <package>

# 🧩 Running Code or Tools
# Run a Python script inside the managed venv
uv run python script.py

# Run CLI tools from the virtualenv
uv run pytest
uv run black .
uv run uvicorn app:app

# install Python version
uv python install 3.11

#  Tools
uv tool install black
# add tools globally?
uv tool update-shell

# 🚀 Project Initialization
# Initialize a new uv project with pyproject.toml + venv
uv init
uv init project-name-folder

# 🧼 Cache and Info
# Clean the uv package cache
uv cache clean
# Show info about a package
uv pip show <package>
uv tree
# Validate locked dependencies
uv pip check

# 🧠 Tip: Define custom scripts in pyproject.toml
# [tool.uv.scripts]
# start = "python script.py"
# Then run:
uv run start
```

