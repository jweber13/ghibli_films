require 'singleton'

class FilmRepository
  include Singleton

  attr_reader :films, :last_id

  def initialize
    @films = {}
    @last_id = 0
  end

  def all
    @films.values
  end

  def find(id)
    @films[id]
  end

  def create(attributes)
    film = Film.new(attributes)
    save(film)
  end

  def save(film)
    film.id ||= generate_id
    @films[film.id] = film
  end

  def delete(id)
    @films.delete(id)
  end

  def clear
    @films = {}
  end

  def search(query)
    query = query.downcase
    @films.values.select do |film|
      film_attributes = [
        film.title,
        film.original_title,
        film.description,
        film.director,
        film.producer
      ]
      film_attributes.any? { |attribute| attribute&.downcase&.include?(query) }
    end
  end

  private

  def generate_id
    @last_id += 1
  end
end
