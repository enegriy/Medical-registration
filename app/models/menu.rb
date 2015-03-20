class Menu < ActiveRecord::Base

	attr_accessible :title, :controller, :action

	has_many :menu_link_roles
	has_many :roles, :through => :menu_link_roles

end
