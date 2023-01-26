require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://www2.assemblee-nationale.fr/deputes/liste/tableau"

def get_depute_email(page_url)
  email = Nokogiri::HTML(URI.open(page_url)).xpath("//ul/li[1]/a/span[2]").text
  puts "Scraped #{email} !"
  email
end

def transform_url(url_ending)
  "https://www.assemblee-nationale.fr/dyn" + url_ending.gsub(/fiche\/OMC_/, '')
end

def get_all_deputes_emails(directory_url)
  res = []
  deputes = Nokogiri::HTML(URI.open(directory_url)).xpath("//tr/td[1]")
  prefix = 'https://www.assemblee-nationale.fr/dyn'
  deputes.each do |depute|
    first_name = depute['data-sort'].split('_')[1].to_s 
    last_name = depute['data-sort'].split('_')[0].to_s 
    email = get_depute_email(transform_url(depute.children[1]['href']))
    res << { 'first_name' =>first_name, 'last_name' =>last_name, 'email' =>email }
    puts "Added #{first_name} #{last_name} to the results (control : #{res[-1..]}."
  end
  res
end

def perform(directory_url)
  get_all_deputes_emails(directory_url).each do |depute|
    p depute
  end
end

perform(PAGE_URL)

