98034 Luxury Homes For Sale - 154 Homes | Zillow



https://www.zillow.com/kirkland-wa-98034/luxury-homes/?searchQueryState=%7B%22pagination%22%3A%7B%7D%2C%22isMapVisible%22%3Atrue%2C%22mapBounds%22%3A%7B%22west%22%3A-122.25886705065916%2C%22east%22%3A-122.1539819493408%2C%22south%22%3A47.67035196937749%2C%22north%22%3A47.76240062211607%7D%2C%22regionSelection%22%3A%5B%7B%22regionId%22%3A99519%2C%22regionType%22%3A7%7D%5D%2C%22filterState%22%3A%7B%22sort%22%3A%7B%22value%22%3A%22priced%22%7D%7D%2C%22isListVisible%22%3Atrue%2C%22mapZoom%22%3A13%2C%22usersSearchTerm%22%3A%22Kirkland%20WA%2098034%22%7D


```
Get me a short listing of the properties on this page. address, price, beds, baths. URLs, format as JSON
```

Co=pilot askes for this.
Context clues
 
Copilot may give better answers based on the current webpage, open tabs, browser history, or your preferences in Microsoft Edge.Learn more
That's a great start, but the page lists 154 results, and your JSON only shows me 5 of them.  Is there a way to get the rest ?

Here are a few ways you could get the full list:
1.	Scroll through the entire page: Let all listings load, then ask me again — I’ll be able to extract more.
OK, I've scrolled to the end of the first page. Let's try again.


Can you write a short script that will be able to find these addresses on the propwire.com site?
I.e. convert the address, or url into something I can cross reference the property on the other site?



Sure! Here's a short Python script that takes a list of property addresses and constructs search URLs for Propwire.com.. Since Propwire doesn’t offer a public API, this script uses basic URL encoding to simulate a search query you could paste into a browser:

import urllib.parse

# List of property addresses
addresses = [
    "8625 NE Juanita Drive, Kirkland, WA 98034",
    "7128 NE 119th Lane, Kirkland, WA 98034",
    "7116 NE 119th Lane, Kirkland, WA 98034",
    "10939 84th Place NE, Kirkland, WA 98034",
    "8814 NE Juanita Drive, Kirkland, WA 98034"
]

# Base search URL for Propwire
base_url = "https://propwire.com/search?q="

# Generate search URLs
search_urls = [base_url + urllib.parse.quote(address) for address in addresses]

# Print results
for url in search_urls:
    print(url)

https://propwire.com/search?q=8625%20NE%20Juanita%20Drive%2C%20Kirkland%2C%20WA%2098034

o, it looks like I will have to type the address into Propwire's address input box, on the main page.  Is there a way I can automate that?  Is there a method in python? or JS?

Yes, you can automate typing addresses into Propwire’s input box using browser automation tools. Here are two popular approaches:

🐍 Python with Selenium
Selenium lets you control a browser programmatically. Here's a basic example:

python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time

# Set up the browser (make sure you have the correct driver installed)
driver = webdriver.Chrome()

# Go to Propwire
driver.get("https://propwire.com")

# Wait for page to load
time.sleep(3)

# Find the address input box (adjust selector if needed)
search_box = driver.find_element(By.CSS_SELECTOR, "input[placeholder='Search by address']")

# Type the address
address = "8625 NE Juanita Drive, Kirkland, WA 98034"
search_box.send_keys(address)
search_box.send_keys(Keys.RETURN)

# Optional: wait for results to load
time.sleep(5)

# Close browser
# driver.quit()
💻 JavaScript with Puppeteer
If you prefer Node.js, Puppeteer is a great headless browser tool:

javascript
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({ headless: false });
  const page = await browser.newPage();
  await page.goto('https://propwire.com');

  // Wait for input box
  await page.waitForSelector("input[placeholder='Search by address']");

  // Type the address
  const address = "8625 NE Juanita Drive, Kirkland, WA 98034";
  await page.type("input[placeholder='Search by address']", address);
  await page.keyboard.press('Enter');

  // Wait for results
  await page.waitForTimeout(5000);

  // await browser.close();
})();
Would you like to loop through multiple addresses or extract results too? I can help build that out.



OK Puppeteer looks better, or can you do it with ruby?  As for looping, I think open a series of browser tabs would be great, and then we can focus on extraction of the results.

Absolutely! You can automate this in **Ruby** using the [Ferrum](https://github.com/rubycdp/ferrum) or [Watir](https://github.com/watir/watir) libraries. Ferrum is a headless browser driver for Chrome, and Watir wraps Selenium for a more Ruby-like syntax. Here's how to do it with Ferrum:

---

### 🧪 Ruby + Ferrum: Open Multiple Tabs with Addresses

```ruby
require 'ferrum'

# List of addresses
addresses = [
  "8625 NE Juanita Drive, Kirkland, WA 98034",
  "7128 NE 119th Lane, Kirkland, WA 98034",
  "7116 NE 119th Lane, Kirkland, WA 98034"
]

# Start browser
browser = Ferrum::Browser.new

addresses.each do |address|
  # Open a new tab
  tab = browser.context.create_page
  tab.go_to("https://propwire.com")

  # Wait for input box and type address
  tab.at_css("input[placeholder='Search by address']").focus.type(address)
  tab.keyboard.type(:enter)

  # Optional: wait for results to load
  sleep 3
end

# Keep browser open
puts "Tabs opened. Press Enter to close..."
gets
browser.quit
```

---

### 🧪 Ruby + Watir (Selenium Wrapper)

```ruby
require 'watir'

addresses = [
  "8625 NE Juanita Drive, Kirkland, WA 98034",
  "7128 NE 119th Lane, Kirkland, WA 98034",
  "7116 NE 119th Lane, Kirkland, WA 98034"
]

browser = Watir::Browser.new :chrome

addresses.each do |address|
  browser.window.open
  browser.window.last.use
  browser.goto "https://propwire.com"
  browser.text_field(placeholder: 'Search by address').set(address)
  browser.send_keys :enter
  sleep 3
end

puts "All tabs opened. Press Enter to close..."
gets
browser.close
```

---

Both approaches will open a tab for each address and submit the search. Once you're ready to extract results, I can help you parse the listings from each tab. Want to move on to scraping the results next?

Great plan — Propwire provides detailed property data, and you can automate filtering based on equity and other financials. Here's how to approach it:

---

### 🔍 What You Can Extract from Propwire

From each listing page, you can typically find:

- **Estimated Property Value**
- **Estimated Mortgage Balance**
- **Estimated Equity** (often shown as a percentage)
- **Tax Information**:
  - Tax Year
  - Tax Amount
  - Assessed Value
- **Mortgage Info** (if available):
  - Balance
  - Loan Type (sometimes)
  - Lender (rarely)

---

### ✅ Filtering Logic

To reject listings with less than 70% equity:

```ruby
def equity_percentage(value, mortgage)
  return 0 if value.nil? || mortgage.nil? || value == 0
  ((value - mortgage) / value.to_f * 100).round
end

def eligible?(value, mortgage)
  equity_percentage(value, mortgage) >= 70
end
```

---

### 🧪 Extraction Strategy

Once you’ve opened the listing tabs (via Ferrum or Watir), you can extract the data like this:

#### Ferrum Example (Ruby)

```ruby
value_text = page.at_css("div:contains('Estimated Property Value')")&.text
mortgage_text = page.at_css("div:contains('Est. Mortgage Balance')")&.text

value = value_text.scan(/\$[\d,]+/).first&.delete("$,")&.to_i
mortgage = mortgage_text.scan(/\$[\d,]+/).first&.delete("$,")&.to_i

if eligible?(value, mortgage)
  puts "✅ Eligible: Equity #{equity_percentage(value, mortgage)}%"
else
  puts "❌ Rejected: Equity #{equity_percentage(value, mortgage)}%"
end
```

You can also extract tax info similarly:

```ruby
tax_amount = page.at_css("div:contains('Tax Amount')")&.text
tax_year = page.at_css("div:contains('Tax Year')")&.text
```

---

Would you like help bundling this into a full Ruby script that loops through tabs and extracts all the data? Or prefer to try it in Puppeteer/JS instead?

Perfect — here's a Ruby + Ferrum script outline that reads your Zillow JSON file, opens each address in Propwire, extracts key financial data, and appends it to the original JSON structure.

---

### 🧰 Prerequisites

Install Ferrum and JSON support:

```bash
gem install ferrum
```

---

### 📜 Script: Enrich Zillow Data with Propwire Info

```ruby
require 'json'
require 'ferrum'

# Load Zillow data
zillow_data = JSON.parse(File.read("zillow_listings.json"))

# Start browser
browser = Ferrum::Browser.new

# Helper to extract numeric value from text
def extract_dollars(text)
  text&.scan(/\$[\d,]+/)&.first&.delete("$,")&.to_i
end

# Loop through each listing
zillow_data.each do |listing|
  address = listing["address"]
  puts "🔍 Searching: #{address}"

  # Open Propwire and search
  page = browser.context.create_page
  page.go_to("https://propwire.com")
  page.at_css("input[placeholder='Search by address']").focus.type(address)
  page.keyboard.type(:enter)
  sleep 5 # wait for results

  # Extract values
  value_text = page.at_css("div:contains('Estimated Property Value')")&.text
  mortgage_text = page.at_css("div:contains('Est. Mortgage Balance')")&.text
  equity_text = page.at_css("div:contains('Estimated Equity')")&.text
  tax_text = page.at_css("div:contains('Tax Amount')")&.text
  tax_year_text = page.at_css("div:contains('Tax Year')")&.text

  # Parse values
  value = extract_dollars(value_text)
  mortgage = extract_dollars(mortgage_text)
  equity = extract_dollars(equity_text)
  tax = extract_dollars(tax_text)
  tax_year = tax_year_text&.scan(/\d{4}/)&.first

  # Filter by equity
  equity_percent = value && mortgage ? ((value - mortgage) / value.to_f * 100).round : nil
  listing["propwire"] = {
    "estimated_value" => value,
    "mortgage_balance" => mortgage,
    "equity_percent" => equity_percent,
    "tax_amount" => tax,
    "tax_year" => tax_year
  }

  if equity_percent && equity_percent < 70
    puts "❌ Skipping: Equity #{equity_percent}%"
    next
  else
    puts "✅ Accepted: Equity #{equity_percent}%"
  end
end

# Save enriched data
File.write("zillow_enriched.json", JSON.pretty_generate(zillow_data))
puts "✅ Enriched data saved to zillow_enriched.json"
```

---

This script:
- Reads your original Zillow JSON
- Searches each address on Propwire
- Extracts estimated value, mortgage, equity %, tax info
- Filters out listings with <70% equity
- Saves the enriched data to a new JSON file

Want help adding mortgage details or scraping more fields next?

10931 NE 133rd Street, Kirkland, WA 98034

Your Ferrum script won't automatically inherit the login session from another browser window — each Ferrum browser instance runs in its own isolated context. To access account-restricted data like open mortgages, you'll need to handle authentication directly within Ferrum.

Here are your options:

---

### ✅ Option 1: Automate Login in Ferrum

You can script the login process at the start of your session:

```ruby
browser = Ferrum::Browser.new
page = browser.goto("https://propwire.com/login")

# Fill in login form
page.at_css("input[name='email']").focus.type("your_email@example.com")
page.at_css("input[name='password']").focus.type("your_password")
page.keyboard.type(:enter)

# Wait for login to complete
sleep 5
```

Once logged in, all subsequent pages will have access to your account data.

---

### 🧠 Option 2: Load Session Cookies (Advanced)

If you already have a valid session in another browser, you could export cookies and inject them into Ferrum:

1. Use browser dev tools to export cookies for `propwire.com`
2. In Ferrum:

```ruby
browser = Ferrum::Browser.new
browser.cookies.set(name: "session", value: "your_session_token", domain: "propwire.com")
```

This is trickier and may break if Propwire uses secure or short-lived tokens.

---

### 🔐 Option 3: Manual Login Once

Run Ferrum in non-headless mode (`headless: false`) and log in manually:

```ruby
browser = Ferrum::Browser.new(headless: false)
browser.goto("https://propwire.com/login")
puts "Log in manually, then press Enter to continue..."
gets
```

After login, the session persists for that browser instance.

Absolutely — here's a complete Ruby script using **Ferrum** that:

1. Logs into Propwire with your credentials  
2. Reads your Zillow JSON file  
3. Opens a tab for each property address  
4. Extracts financial data (value, mortgage, equity, tax info)  
5. Filters out listings with <70% equity  
6. Appends the data to the original JSON  
7. Leaves all tabs open for manual inspection  
8. Saves the enriched JSON to a new file  

---

### 🧩 Full Ruby Script: `propwire_enrich.rb`

```ruby
require 'json'
require 'ferrum'

# === CONFIG ===
EMAIL = "your_email@example.com"
PASSWORD = "your_password"
INPUT_FILE = "zillow_listings.json"
OUTPUT_FILE = "zillow_enriched.json"

# === HELPERS ===
def extract_dollars(text)
  text&.scan(/\$[\d,]+/)&.first&.delete("$,")&.to_i
end

def equity_percent(value, mortgage)
  return nil if value.nil? || mortgage.nil? || value == 0
  ((value - mortgage) / value.to_f * 100).round
end

# === START BROWSER ===
browser = Ferrum::Browser.new(headless: false)
page = browser.goto("https://propwire.com/login")

# === LOGIN ===
page.at_css("input[name='email']").focus.type(EMAIL)
page.at_css("input[name='password']").focus.type(PASSWORD)
page.keyboard.type(:enter)
sleep 5

# === LOAD ZILLOW DATA ===
zillow_data = JSON.parse(File.read(INPUT_FILE))

# === PROCESS EACH LISTING ===
zillow_data.each do |listing|
  address = listing["address"]
  puts "🔍 Searching: #{address}"

  tab = browser.context.create_page
  tab.go_to("https://propwire.com")
  tab.at_css("input[placeholder='Search by address']").focus.type(address)
  tab.keyboard.type(:enter)
  sleep 5

  # Extract financial data
  value_text = tab.at_css("div:contains('Estimated Property Value')")&.text
  mortgage_text = tab.at_css("div:contains('Est. Mortgage Balance')")&.text
  equity_text = tab.at_css("div:contains('Estimated Equity')")&.text
  tax_text = tab.at_css("div:contains('Tax Amount')")&.text
  tax_year_text = tab.at_css("div:contains('Tax Year')")&.text

  value = extract_dollars(value_text)
  mortgage = extract_dollars(mortgage_text)
  equity = extract_dollars(equity_text)
  tax = extract_dollars(tax_text)
  tax_year = tax_year_text&.scan(/\d{4}/)&.first
  equity_pct = equity_percent(value, mortgage)

  listing["propwire"] = {
    "estimated_value" => value,
    "mortgage_balance" => mortgage,
    "equity_percent" => equity_pct,
    "tax_amount" => tax,
    "tax_year" => tax_year
  }

  if equity_pct && equity_pct < 70
    puts "❌ Rejected: Equity #{equity_pct}%"
  else
    puts "✅ Accepted: Equity #{equity_pct}%"
  end
end

# === SAVE OUTPUT ===
File.write(OUTPUT_FILE, JSON.pretty_generate(zillow_data))
puts "✅ Enriched data saved to #{OUTPUT_FILE}"
puts "🧭 Tabs remain open for manual inspection."
```

---
Absolutely! Here's a complete Ruby script using **Ferrum** that:

- Opens a Zillow search page  
- Scrolls down to load all listings dynamically  
- Extracts address, price, beds, baths, and URL for each listing  
- Saves the results in a clean JSON format  

---

### 🧰 Prerequisites

Install Ferrum and Nokogiri:

```bash
gem install ferrum nokogiri
```

---

### 📜 Script: `zillow_scraper.rb`

```ruby
require 'ferrum'
require 'nokogiri'
require 'json'

# === CONFIG ===
ZILLOW_URL = "https://www.zillow.com/kirkland-wa-98034/luxury-homes/"
OUTPUT_FILE = "zillow_listings.json"

# === START BROWSER ===
browser = Ferrum::Browser.new(headless: false)
page = browser.goto(ZILLOW_URL)

# === SCROLL TO LOAD ALL LISTINGS ===
scroll_pause = 2
max_scrolls = 20
last_height = page.evaluate("document.body.scrollHeight")

max_scrolls.times do
  page.evaluate("window.scrollTo(0, document.body.scrollHeight)")
  sleep scroll_pause
  new_height = page.evaluate("document.body.scrollHeight")
  break if new_height == last_height
  last_height = new_height
end

# === PARSE LISTINGS ===
doc = Nokogiri::HTML(page.body)
listings = []

doc.css("article").each do |card|
  address = card.at_css("address")&.text&.strip
  price = card.at_css("span[data-test='property-card-price']")&.text&.strip
  beds = card.at_css("ul li:contains('bd')")&.text&.match(/\d+/)&.to_s&.to_i
  baths = card.at_css("ul li:contains('ba')")&.text&.match(/\d+/)&.to_s&.to_i
  url = card.at_css("a")&.[]("href")
  url = "https://www.zillow.com#{url}" if url && !url.start_with?("http")

  next unless address && price && url

  listings << {
    "address" => address,
    "price" => price,
    "beds" => beds,
    "baths" => baths,
    "url" => url
  }
end

# === SAVE OUTPUT ===
File.write(OUTPUT_FILE, JSON.pretty_generate(listings))
puts "✅ Saved #{listings.size} listings to #{OUTPUT_FILE}"
```

---

### 🧭 Notes

- This script scrolls the page to load all listings before scraping.
- It uses Nokogiri to parse the HTML and extract key fields.
- You can adjust `max_scrolls` or `scroll_pause` if Zillow loads slowly or has more results.

Would you like to combine this with your Propwire enrichment script for a full pipeline?

### 🛠 Notes

- Replace `EMAIL` and `PASSWORD` with your Propwire credentials.
- You can inspect tabs manually since the browser is non-headless.
- You can later add scraping for owner info, sale history, or mortgage type if needed.

Want me to help you add CSV export or automate screenshots of each tab next?

---

Let me know which route you prefer — I can help you script it cleanly.
Absolutely! Here's a complete Ruby script using **Ferrum** that:

- Opens a Zillow search page  
- Scrolls down to load all listings dynamically  
- Extracts address, price, beds, baths, and URL for each listing  
- Saves the results in a clean JSON format  

---

### 🧰 Prerequisites

Install Ferrum and Nokogiri:

```bash
gem install ferrum nokogiri
```

---

### 📜 Script: `zillow_scraper.rb`

```ruby
require 'ferrum'
require 'nokogiri'
require 'json'

# === CONFIG ===
ZILLOW_URL = "https://www.zillow.com/kirkland-wa-98034/luxury-homes/"
OUTPUT_FILE = "zillow_listings.json"

# === START BROWSER ===
browser = Ferrum::Browser.new(headless: false)
page = browser.goto(ZILLOW_URL)

# === SCROLL TO LOAD ALL LISTINGS ===
scroll_pause = 2
max_scrolls = 20
last_height = page.evaluate("document.body.scrollHeight")

max_scrolls.times do
  page.evaluate("window.scrollTo(0, document.body.scrollHeight)")
  sleep scroll_pause
  new_height = page.evaluate("document.body.scrollHeight")
  break if new_height == last_height
  last_height = new_height
end

# === PARSE LISTINGS ===
doc = Nokogiri::HTML(page.body)
listings = []

doc.css("article").each do |card|
  address = card.at_css("address")&.text&.strip
  price = card.at_css("span[data-test='property-card-price']")&.text&.strip
  beds = card.at_css("ul li:contains('bd')")&.text&.match(/\d+/)&.to_s&.to_i
  baths = card.at_css("ul li:contains('ba')")&.text&.match(/\d+/)&.to_s&.to_i
  url = card.at_css("a")&.[]("href")
  url = "https://www.zillow.com#{url}" if url && !url.start_with?("http")

  next unless address && price && url

  listings << {
    "address" => address,
    "price" => price,
    "beds" => beds,
    "baths" => baths,
    "url" => url
  }
end

# === SAVE OUTPUT ===
File.write(OUTPUT_FILE, JSON.pretty_generate(listings))
puts "✅ Saved #{listings.size} listings to #{OUTPUT_FILE}"
```

---

### 🧭 Notes

- This script scrolls the page to load all listings before scraping.
- It uses Nokogiri to parse the HTML and extract key fields.
- You can adjust `max_scrolls` or `scroll_pause` if Zillow loads slowly or has more results.

Would you like to combine this with your Propwire enrichment script for a full pipeline?
