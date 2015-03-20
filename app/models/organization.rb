class Organization < ActiveRecord::Base

	attr_accessible :name, :street, :number
	
	has_many :doctors
	belongs_to :city

	validates	:name,
				:street,
				:city_id,
				:number,
				:presence => true

	validates :name, :uniqueness => true
	validates :name, :length => { :maximum => 100 }

	default_scope :order=>:name
end
