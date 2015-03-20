class ProgOption < ActiveRecord::Base

  validates :option, :uniqueness => true

end
