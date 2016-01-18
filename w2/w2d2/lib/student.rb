class Student
	attr_reader :first_name, :last_name, :courses

	def initialize(first_name, last_name)
		@first_name = first_name
		@last_name = last_name
		@courses = []
	end

	def name
		name = "#{first_name} #{last_name}"
	end

	def enroll(course)
		return if courses.include?(course)
		raise "Already enrolled" if has_conflict?(course)
		courses << course
		course.students << self
	end

	def course_load
		credits_per_department = Hash.new(0)
		courses.each do |course|
			credits_per_department[course.department] += course.credits
		end
		credits_per_department
	end

	def has_conflict?(course)
		self.courses.each do |c|
			return true if c.conflicts_with?(course)
		end
		false
	end

end
