require 'nokogiri'
require 'open-uri'
require 'openssl'

PAGE_URL = "https://www.annuaire-des-mairies.com/val-d-oise.html"

def get_townhall_email(townhall_url)
  email = Nokogiri::HTML(URI.open(townhall_url, {ssl_verify_mode: 0})).xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  email.empty? ? puts("Didn't find the email !") : puts("Scraped #{email}")
  email
end

def get_townhall_urls(directory_url)
  cities = Nokogiri::HTML(URI.open(directory_url, {ssl_verify_mode: 0})).xpath("//tr[3]/td//td[2]//td[@width='627']//a")
  #return cities
  prefix = "https://www.annuaire-des-mairies.com"
  res = []
  cities.each do |city|
    res << [[city.text, prefix + city['href'][1..]]].to_h
    puts "Adding #{[city.text, prefix + city['href'][1..]]} to list (control : #{res[-1..]})."
  end
  res
end

def get_townhall_emails_from_URL_hash(url_array)
  res = []
  url_array.each do |hash|
    hash.each do |city, url|
      email = get_townhall_email(url)
      unless email.empty? 
        res << {city =>email}
        puts "Replacing #{city}'s url with its email (control : #{res[-1..]})."
      else
        puts "Email is not provided for #{city} : deleting item"
      end
    end
  end
  res 
end
  
def perform(directory_url)
  get_townhall_emails_from_URL_hash(get_townhall_urls(directory_url)).each do |hash|
    p hash
  end
end

perform(PAGE_URL)

