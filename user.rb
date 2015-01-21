class User

	attr_accessor :id

	def initialize(id)
		@id = id
		@ratingsGiven = {}
	end
	
	def getRatingForMovie(movie)
		if(hasRatedMovie(movie))
			return @ratingsGiven[movie].rating
		else 
			return nil
		end
	end

	def hasRatedMovie(movie)
		return @ratingsGiven.has_key?(movie)
	end
	
	def addRating(ratingInstance)
		@ratingsGiven[ratingInstance.movie] = ratingInstance
	end
	
	def similarity(otherUser,numDimensions)
		return cosineSimilarity(otherUser,numDimensions)
	end
	
	def cosineSimilarityOmission(otherUser)
		dotProduct = 0
		@ratingsGiven.keys.each do |movie|
			if(otherUser.hasRatedMovie(movie))
				dotProduct += otherUser.getRatingForMovie(movie)*getRatingForMovie(movie)
			end
		end
		return dotProduct / (cosineMagnitudeOmission(otherUser) * otherUser.cosineMagnitudeOmission(self))
	end
	
	def cosineMagnitudeOmission(otherUser)
		sumOfSquares = 0
		@ratingsGiven.keys.each do |movie|
			if(otherUser.hasRatedMovie(movie)) 
				sumOfSquares+=(getRatingForMovie(movie)) ** 2
			end
		end
		return sumOfSquares ** 0.5
	end
	
	def cosineSimilarity(otherUser,numDimensions)
		dotProduct = 0
		@ratingsGiven.keys.each do |movie|
			if(otherUser.hasRatedMovie(movie))
				dotProduct += otherUser.getRatingForMovie(movie)*getRatingForMovie(movie)
			else
				dotProduct += 1
			end
		end
		dotProduct+=1*(numDimensions - @ratingsGiven.size)
		return dotProduct / (cosineMagnitude(numDimensions) * otherUser.cosineMagnitude(numDimensions))
	end
	
	def cosineMagnitude(numDimensions)
		sumOfSquares = 0
		@ratingsGiven.keys.each do |movie|
			sumOfSquares+=(getRatingForMovie(movie)) ** 2
		end
		sumOfSquares+= 1*(numDimensions - @ratingsGiven.size)
		return sumOfSquares ** 0.5
	end
	
	def euclideanSimilarity(otherUser,numDimensions)
		sumOfSquares = 0
		@ratingsGiven.keys.each do |movie|
			if(otherUser.hasRatedMovie(movie))
				sumOfSquares+=(otherUser.getRatingForMovie(movie) - getRatingForMovie(movie)) ** 2
			else
				sumOfSquares+=4
			end
		end
		sumOfSquares+= 4*(numDimensions - @ratingsGiven.size)
		return 100-(sumOfSquares ** 0.5)
	end
	
	def getSetOfMoviesRated
		return @ratingsGiven.keys
	end
	
	def numberOfMoviesRated
		return @ratingsGiven.size
	end
	
	def to_s
		return "ID: #{@id}"
	end
	
end