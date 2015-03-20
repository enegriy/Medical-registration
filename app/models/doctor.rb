class Doctor < ActiveRecord::Base

	attr_accessible :organization_id, :soname, :name, :second_name, :spec_id, :experience, :work_phone, :is_come_home, :note

	validates :soname, :name, :spec_id, :work_phone, :organization_id,
						:presence => true

	has_one :user

	belongs_to :spec
	belongs_to :organization

	has_many :timetables
	has_many :doctor_absences
	has_many :tickets
	has_many :blacklists


	self.per_page = 10
end
