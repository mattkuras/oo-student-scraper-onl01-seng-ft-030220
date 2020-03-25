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
 
     links = doc.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}

       hash = {}
       
       if links[0].include?("twitter") 
         hash[:twitter] = links[0]
       end 
       if links[1].include?("linkedin") 
         hash[:linkedin] = links[1]
       end
       if links[2] && links[2]include?("github") 
         hash[:github] = links[2]
       end
       if links[3].include?(".com") 
         hash[:blog] = links[3]
       end
       
       hash[:profile_quote]  = doc.css(".vitals-text-container div").text
       hash[:bio] = doc.css(".details-container p").text
       
      binding.pry 
       
       hash 
  end
end

