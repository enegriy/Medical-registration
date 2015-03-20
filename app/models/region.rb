class Region < ActiveRecord::Base

  has_many :cities

  default_scope :order=>:name

end
