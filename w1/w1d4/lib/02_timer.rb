class Timer
	attr_accessor :seconds

	def initialize (seconds = 0)
		@seconds = seconds
	end

	def time_string
		"#{padded(just_hours)}:#{padded(just_minutes)}:#{padded(just_seconds)}"
	end

	def just_hours
		seconds / 3600
	end


	def just_minutes
		(seconds / 60) % 60
	end

	def just_seconds
		seconds % 60
	end

	def padded(num)
		num_as_str = num.to_s
		num_as_str.length == 1 ? "0" + num_as_str : num_as_str
	end
end