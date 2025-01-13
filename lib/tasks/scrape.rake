task(:scrape) do
  require "json"
  require "tmdb"
  require "date"
  
  # Choose start and end years
  start_year = 2015
  end_year = 2024

  # Setup TMDB
  Tmdb::Api.key(ENV.fetch("TMDB_KEY"))
  
  # Read Oscar nominees JSON
  oscar_data = JSON.parse(File.read("scraped_oscar_nominees_#{start_year}to#{end_year}.json"))
  output_file = "sample_data_#{start_year}to#{end_year}.json"
  
  # Initialize arrays to store details
  movie_details = []
  director_details = []
  actor_details = []
  character_details = []
  
  # Character IDs need to be globally unique
  character_id_counter = 0
  
  # Extract unique movies from Oscar data
  oscar_movies = oscar_data.flat_map do |year|
    year["nominations"].map { |nom| nom["film"] }
  end
  
  # Process each movie
  oscar_movies.each_with_index do |movie_title, index|
    # Search for movie in TMDB
    search = Tmdb::Search.movie(movie_title)
    next if search.results.empty?
    
    # Filter for movies released between start and end years
    correct_movie = search.results.find do |result|
      release_year = Date.parse(result.release_date).year
      release_year.between?(start_year, end_year)
    end
    
    next if correct_movie.nil?
    
    movie = Tmdb::Movie.detail(correct_movie.id)
    
    # Movie details
    movie_details.push({
      id: index + 1,
      description: movie.overview,
      duration: movie.runtime,
      image: "https://image.tmdb.org/t/p/w500#{movie.poster_path}",
      title: movie.title,
      year: Date.parse(movie.release_date).year,
      created_at: "2024-03-14 12:00:00",
      updated_at: "2024-03-14 12:00:00",
      director_id: nil # Will update after getting director
    })
  
    # Get director
    director = Tmdb::Movie.director(movie.id)[0]
    if director
      director_obj = Tmdb::Person.detail(director.id)
      director_details.push({
        id: director.id,
        bio: director_obj.biography,
        dob: director_obj.birthday,
        image: director_obj.profile_path ? 
          "https://image.tmdb.org/t/p/w500#{director_obj.profile_path}" : 
          "https://robohash.org/#{director_obj.name}?set=set3",
        name: director_obj.name,
        created_at: "2024-03-14 12:00:00",
        updated_at: "2024-03-14 12:00:00"
      })
      
      # Update movie"s director_id
      movie_details.last[:director_id] = director.id
    end
  
    # Get cast/characters
    cast = Tmdb::Movie.cast(movie.id)
    cast.each do |member|
      character_id_counter += 1  # Increment before each use
      
      # Add actor details
      actor_obj = Tmdb::Person.detail(member.id)
      actor_details.push({
        id: member.id,
        bio: actor_obj.biography,
        dob: actor_obj.birthday,
        image: actor_obj.profile_path ? 
          "https://image.tmdb.org/t/p/w500#{actor_obj.profile_path}" : 
          "https://robohash.org/#{actor_obj.name}?set=set3",
        name: actor_obj.name,
        created_at: "2024-03-14 12:00:00",
        updated_at: "2024-03-14 12:00:00"
      })
  
      # Add character details with globally unique ID
      character_details.push({
        id: character_id_counter,
        name: member.character,
        created_at: "2024-03-14 12:00:00",
        updated_at: "2024-03-14 12:00:00",
        actor_id: member.id,
        movie_id: index + 1
      })
    end
  end
  
  # Remove duplicates while preserving IDs
  actor_details.uniq! { |actor| actor[:id] }
  director_details.uniq! { |director| director[:id] }
  
  # Write to JSON file
  output = {
    movies: movie_details,
    directors: director_details,
    actors: actor_details,
    characters: character_details
  }
  
  File.write(output_file, JSON.pretty_generate(output))
  

end
