class Movie

	attr_accessor :id

	def initialize(id)
		@id = id
		@ratingsReceived = {}
		@popularity = 0
		@popularityIsDirty = true
	end
	
	def popularity
		if(@popularityIsDirty) 
			calculatePopularity
		end
		return @popularity
	end
	
	def calculatePopularity

		calculateTrueBayesianAverageProbability
		@popularityIsDirty = false
	end
	
	def calculateTrueBayesianAverageProbability
		allRatings = @ratingsReceived.values
		numberOfRatings = allRatings.length
		@popularity = 0
		averageRating = 0
		allRatings.each do |ratingInstance|
			averageRating+=ratingInstance.rating
		end
		averageRating /= numberOfRatings
		
		smoothingTarget = 3
		smoothingStrength = 5
		
		@popularity = (averageRating*numberOfRatings + smoothingTarget*smoothingStrength).fdiv(numberOfRatings + smoothingStrength)
	end
	
	def calculateAverageRating
		allRatings = @ratingsReceived.values
		numberOfRatings = allRatings.length
		@popularity = 0
		averageRating = 0
		allRatings.each do |ratingInstance|
			averageRating+=ratingInstance.rating
		end
		averageRating /= numberOfRatings
		@popularity = averageRating
	end
	
	def getRatingFromUser(user)
		return @ratingsReceived[user].rating
	end
	
	def wasRatedByUser(user)
		return @ratingsReceived.has_key?(user)
	end
	
	def addRating(ratingInstance)
		@ratingsReceived[ratingInstance.user] = ratingInstance
		@popularityIsDirty = true
	end
	
	def getSetOfRaters
		return @ratingsReceived.keys
	end
	
	def to_s
		return "ID: #{@id} Popularity: #{popularity}"
	end
	
end