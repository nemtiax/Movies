require_relative 'user'
require_relative 'movie'
require_relative 'rating_instance'

class MovieData
	def initialize(moviesFileName)
		@userMap = {}
		@movieMap = {}
		@moviesFileName = moviesFileName
	end

	def load_data
		moviesHandle = File.open(@moviesFileName)
		moviesHandle.each_line do |line|
			processDataLine(line)
		end
		moviesHandle.close
	end
	
	def processDataLine(line) 
		attributes = line.split(/\s+/)
		userID = attributes[0]
		movieID = attributes[1]
		rating = Integer(attributes[2])
		
		if(not @userMap.has_key?(userID))
			@userMap[userID] = User.new(userID)
		end
		user = @userMap[userID]
		
		if(not @movieMap.has_key?(movieID))
			@movieMap[movieID] = Movie.new(movieID)
		end
		movie = @movieMap[movieID]
		
		ratingInstance = RatingInstance.new(user,movie,rating)
		
		user.addRating(ratingInstance)
		movie.addRating(ratingInstance)
	end
	
	def popularity(movie_id)
		movie = @movieMap[movie_id]
		return movie.popularity
	end
	
	def popularity_list
		return movies.sort_by { |m| m.popularity }
	end
	
	def similarity(user1,user2)
		return user1.similarity(user2,movies.size)
	end
	
	def mostSimilar(user)
		similarityMap = {}
		users.each do |otherUser| 
			if(otherUser != user)
				similarityMap[otherUser] = similarity(user,otherUser)
			end
		end
		
		return similarityMap.keys.sort_by { |u| similarityMap[u] }
	end
	
	def users
		return @userMap.values
	end
	
	def movies
		return @movieMap.values
	end
	
	def getUserByID(id)
		return @userMap[id]
	end
	
	def getMovieByID(id)
		return @movieMap[id]
	end
	
	
end


movie_data = MovieData.new('../ml-100k/u.data')
movie_data.load_data
puts movie_data.popularity_list


maxSimilarity = 0



firstUser = movie_data.getUserByID("181")
secondUser = movie_data.getUserByID("120")

movie_data.users.each do |firstUser|
	movie_data.users.each do |secondUser|
		if(firstUser != secondUser)
			similarity = movie_data.similarity(firstUser,secondUser)
			
			if(similarity > maxSimilarity) 
				maxSimilarity = similarity
				puts "#{firstUser} and #{secondUser} : #{similarity}"
			end
		end
	end
end

movie_data.movies.each do |movie|
	if(firstUser.hasRatedMovie(movie) and secondUser.hasRatedMovie(movie))
	puts "181: #{firstUser.getRatingForMovie(movie)} 120: #{secondUser.getRatingForMovie(movie)}"
	end
end