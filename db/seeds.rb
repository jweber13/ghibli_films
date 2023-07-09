require 'faker'

# Clear the existing films to start fresh
FilmRepository.instance.clear

15.times do
  FilmRepository.instance.create(
    director: Faker::TvShows::Buffy.character,
    title: Faker::JapaneseMedia::StudioGhibli.movie,
    original_title: "映画",
    original_title_romanized: "eiga",
    running_time: 130,
    people: Array.new(3, Faker::Name.name),
    producer: Faker::TvShows::Buffy.actor,
    img_url: "http://source.unsplash.com/featured/?cinema"
  )
end

puts "Seed data created successfully."
