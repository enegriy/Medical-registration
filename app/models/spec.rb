class Spec < ActiveRecord::Base

	attr_accessible :name

	has_many :doctors

	default_scope :order=>("specs.name asc")

	#Метод возвращает все специальности отсортированные по наименованию
	def self.all_order_name
		Spec.order(:name)
	end
end
