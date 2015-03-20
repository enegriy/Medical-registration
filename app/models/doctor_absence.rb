class DoctorAbsence < ActiveRecord::Base

	attr_accessible :doctor_id, :absence_id
	
	belongs_to :absence
	belongs_to :doctor
end
