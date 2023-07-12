require 'net/http'
require 'nokogiri'
require "open-uri"
require 'film'
require 'film_repository'

class GhibliApiService
  API_URL = 'https://ghibli.rest/films'

  def fetch_films
    uri = URI(API_URL)
    response = Net::HTTP.get(uri)
    films = JSON.parse(response)

    films.each do |film_data|
      # binding.pry
      people_names = fetch_people_names(film_data['people'])
      film = Film.new(
        title: film_data['title'],
        original_title: film_data['original_title'],
        original_title_romanized: film_data['original_title_romanised'],
        description: film_data['description'],
        producer: film_data['producer'],
        release_date: film_data['release_date'],
        running_time: film_data['running_time'],
        image_url: film_data['image'],
        director: film_data['director'],
        people: people_names
      )
      FilmRepository.instance.save(film)
    end
  end

  def fetch_people_names(people_urls)
    people_names = []
    return people_names if people_urls[0] == "https://ghibli.rest/people" && people_urls.count == 1
    people_urls.each do |people_url|
      uri = URI(people_url)
      response = Net::HTTP.get(uri)
      person_data = JSON.parse(response)
      # people_names << person_data['name'] if person_data['name'].is_a?(String)
      begin
        people_names << person_data['name']
      rescue TypeError
        puts "Error: Invalid name value for person #{person_data['id']}"
      end
    end
    people_names
  end
end
