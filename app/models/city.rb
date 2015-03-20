class City < ActiveRecord::Base

  has_many :organizations
  belongs_to :region

  default_scope :order=>:name
end
