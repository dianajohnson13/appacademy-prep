class Student
	attr_reader :first_name, :last_name, :courses

	def initialize(first_name, last_name)
		@first_name = first_name.capitalize
		@last_name = last_name.capitalize
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
		credits_per_dept = Hash.new(0)

		courses.each do |course|
			credits_per_dept[course.department] += course.credits
		end

		credits_per_dept
	end

	def has_conflict?(new_course)
		self.courses.each do |course|
			return true if course.conflicts_with?(new_course)
		end
		false
	end

end
