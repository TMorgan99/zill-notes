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
