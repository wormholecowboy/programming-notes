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
