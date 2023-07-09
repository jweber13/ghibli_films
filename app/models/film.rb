class Film
  attr_accessor :id, :title, :release_date, :running_time, :image_url
  attr_reader :original_title, :original_title_romanized, :description, :director, :producer, :people

  def initialize(attributes = {})
    # @id = attributes[:id]
    @title = attributes[:title]
    @original_title = attributes[:original_title]
    @original_title_romanized = attributes[:original_title_romanized]
    @description = attributes[:description]
    @director = attributes[:director]
    @producer = attributes[:producer]
    @release_date = attributes[:release_date]
    @running_time = attributes[:running_time]
    @image_url = attributes[:image_url]
    @people = attributes[:people] || []
  end

  def self.all
    FilmRepository.instance.all
  end

  def self.find(id)
    FilmRepository.instance.find(id)
  end

  def save
    FilmRepository.instance.save(self)
  end

  def update(attributes = {})
    @title = attributes[:title] if attributes.key?(:title)
    @original_title = attributes[:original_title] if attributes.key?(:original_title)
    @original_title_romanized = attributes[:original_title_romanized] if attributes.key?(:original_title_romanized)
    @description = attributes[:description] if attributes.key?(:description)
    @director = attributes[:director] if attributes.key?(:director)
    @producer = attributes[:producer] if attributes.key?(:producer)
    @release_date = attributes[:release_date] if attributes.key?(:release_date)
    @running_time = attributes[:running_time] if attributes.key?(:running_time)
    @image_url = attributes[:image_url] if attributes.key?(:image_url)
    @people = attributes[:people] if attributes.key?(:people)
    save
  end

  def destroy
    FilmRepository.instance.delete(id)
  end
end
