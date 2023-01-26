require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"
Page = Nokogiri::HTML(URI.open(PAGE_URL))

def scrap_names(page)
  res = page.xpath('//tbody//td[3]/div')
  puts "Scraping the third column (cryptos' names)"
  res
end

def scrap_values(page)
  res = page.xpath('//tbody//td[5]/div')
  puts "Scraping the fifth column (cryptos' values)"
  res
end

def fuse_attributes(item1, item2)
  res = []
  item1.zip(item2).each do |symbol, value|
    res << [[symbol.text, value.text]].to_h
    puts "Integrated #{symbol.text} to the results with value #{value.text} (control : #{res[-1..]})"
  end
  res
end

def perform(page)
  fuse_attributes(scrap_names(page), scrap_values(page)).each do |crypto|
    p crypto
  end
end

perform(Page)

