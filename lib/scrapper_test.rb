require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://en.wikipedia.org/wiki/HTML"
page = Nokogiri::HTML(URI.open(PAGE_URL))

labels = page.css("div#mw-content-text.mw-body-content.mw-content-ltr div.mw-parser-output table.infobox tr th.infobox-label")
labels.each { |label| puts label.text }

