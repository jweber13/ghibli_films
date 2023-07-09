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
    binding.pry
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

  private

  def generate_id
    @last_id += 1
  end
end
