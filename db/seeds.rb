require 'uri'
require 'net/http'
require 'json'

# Call API to retrieve top movies
url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NWRiYzcyOGFiOTNiY2QwNThjYmU2MTYzZmVhMjVjYyIsIm5iZiI6MTczMTU4MzgxNi44ODE4OTk2LCJzdWIiOiI2NzM1ZGVhNTI5NTRkMjY0NzYyNTgzMzYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.0xJCgvU4iu_NJI6ujPKgZVsEp410dcLxKVAmUIFt9Vc'

response = http.request(request).read_body
movies = JSON.parse(response)["results"]

# Remove previously created movies
puts "Destroying all previously created movies, bookmarks and lists ..."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all
puts "#{Movie.count} movies left in DB"

# Itterate on results to create movies
puts "Create #{movies.count} movies ..."
movies.each_with_index do |movie, index|
  title = movie["title"]
  overview = movie["overview"]
  poster_url = "https://image.tmdb.org/t/p/w500/#{movie["poster_path"]}"
  rating = movie["vote_average"]
  # puts title
  # puts image
  # puts rating
  Movie.create!(
    title: title,
    overview:overview,
    poster_url:poster_url,
    rating:rating
  )
  puts "Movie #{} created, #{index + 1}/#{movies.count}"
end

puts "#{Movie.count} movies created..."

List.create!(name:"Comedies");
List.create!(name:"Horror Movies");
List.create!(name:"Documentaries");
List.create!(name:"Thrillers");
List.create!(name:"Guilty Pleasures");

puts "#{List.count} list created..."

# Assign movies to list Comedies through bookmark
Bookmark.create!(movie: Movie.first, list:List.first, comment:"Good movie")
Bookmark.create!(movie: Movie.last, list:List.first, comment:"Great movie")


puts  "#{Bookmark.count} Bookmark created..."
