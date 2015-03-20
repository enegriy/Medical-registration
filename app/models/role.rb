class Role < ActiveRecord::Base
	attr_accessible :name

	has_many :users

	has_many :menu_link_roles
	has_many :menus, :through => :menu_link_roles

	default_scope :order=>("roles.id desc")

end
