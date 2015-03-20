class Absence < ActiveRecord::Base

	attr_accessible :title
	has_many :doctor_absences

end
