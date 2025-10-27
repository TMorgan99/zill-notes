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
