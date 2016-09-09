require 'pry'

class Scraping
  def self.create_links
    links = []
    agent = Mechanize.new
    next_page = ""

    while true do
      current_page = agent.get("http://review-movie.herokuapp.com/" + next_page)
      elements = current_page.search('.entry-title a')
      elements.each do |element|
        links << element.get_attribute('href')
      end

      binding.pry

      next_link = current_page.at('.next a')
      break unless next_link
      next_page = next_link.get_attribute('href')
    end

    links.each do |link|
      get_infomation('http://review-movie.herokuapp.com/' + link)
    end
  end

  def self.get_infomation(infomation_url)
    agent = Mechanize.new
    movie_page = agent.get(infomation_url)
    title = movie_page.at('.entry-title').inner_text
    image_url = movie_page.at('.entry-content img').get_attribute('src') if movie_page.at('.entry-content img')
    director = movie_page.at('.director span').inner_text if movie_page.at('.director span')
    detail = movie_page.at('.entry-content p').inner_text if movie_page.at('.entry-content p')
    open_date = movie_page.at('.date span').inner_text if movie_page.at('.date span')

    Product.where(title: title, image_url: image_url, director: director, detail: detail, open_date: open_date).first_or_initialize
    Product.create(title: title, image_url: image_url, director: director, detail: detail, open_date: open_date)
  end
end