class MenuLinkRole < ActiveRecord::Base

	attr_accessible :role_id, :menu_id

	belongs_to :role
	belongs_to :menu

end
