class Daytype < ActiveRecord::Base

	attr_accessible :name
	has_many :timetables

end
