class RatingInstance

	attr_accessor :user
	attr_accessor :movie
	attr_accessor :rating

	def initialize(user,movie,rating)
		@user = user
		@movie = movie
		@rating = rating
	end

end