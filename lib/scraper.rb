require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    students = []
   
    doc = Nokogiri::HTML(open(index_url))
      doc.css(".student-card").each do|student|
       student_hash = {}
       #binding.pry 
       student_hash[:name] = student.css("a div.card-text-container h4.student-name").text
       student_hash[:location] = student.css("a div.card-text-container p.student-location").text
      student_hash[:profile_url] = student.css("a").attr("href").value
      students << student_hash
    end
  students
  end
  

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
      hash = {}
     links = doc.css(".social-icon-container").children.css("a").map do |el| 
       link = el.attribute('href').value 
       
       if link.include?("twitter") 
         hash[:twitter] = link
       
       elsif link.include?("linkedin") 
         hash[:linkedin] = link
       
       elsif link.include?("github") 
         hash[:github] = link
       
       else 
         hash[:blog] = link
       end
       
       hash[:profile_quote]  = doc.css(".vitals-text-container div").text
       hash[:bio] = doc.css(".details-container p").text
       
   # binding.pry 
     end 
       hash 
  end
end

