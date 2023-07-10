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
        film.title
      ]
      film_attributes.any? { |attribute| attribute&.downcase&.include?(query) }
    end
  end

  def paginate(page: 1, per_page: 10)
    films = all
    total_pages = (films.length / per_page.to_f).ceil
    offset = (page.to_i - 1) * per_page
    paginated_films = films[offset, per_page]

    OpenStruct.new(
      current_page: page.to_i,
      per_page: per_page,
      total_entries: films.length,
      total_pages: total_pages,
      records: paginated_films
    )
  end

  private

  def generate_id
    @last_id += 1
  end
end
