require 'open-uri'
require 'Nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card").each do |x|
      student = {}
      student[:name] = x.css(".student-name").text
      student[:location] = x.css(".student-location").text
      student[:profile_url] = x.css("a").attribute("href").text

      students << student 
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile = {} 

    doc.css(".social-icon-container a").each do |x|
      if x.attribute("href").value.include?("twitter")
        profile[:twitter] = x.attribute("href").value
      elsif x.attribute("href").value.include?("linkedin")
        profile[:linkedin] = x.attribute("href").value
      elsif x.attribute("href").value.include?("github")
        profile[:github] = x.attribute("href").value
      else
        profile[:blog] = x.attribute("href").value
      end
    end
    profile[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    # binding.pry
    profile[:bio] = doc.css(".details-container .description-holder p").text

    profile
  end

  #   doc.css(".social-icon-container a").each do |x|
  #     link = x.attribute("href").value
  #     if x.include?("twitter")
  #       profile[:twitter] = link
  #     elsif x.include?("linkedin")
  #       profile[:linkedin] = link
  #     elsif x.include?("github")
  #       profile[:github] = link
  #     elsif x.include?("youtube")
  #       profile[:youtube] = link
  #     else 
  #       profile[:blog] = link
  #     end
  #     profile[:profile_quote] = doc.css(".profile-quote").text
  #     profile[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text 
  #     student
  #   end
  # end
end