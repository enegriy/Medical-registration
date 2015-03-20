class Ticket < ActiveRecord::Base
	
	attr_accessible :visit_date, :doctor_id, :user_id
	

 	belongs_to :doctor
 	belongs_to :user
end
