class User < ActiveRecord::Base
  belongs_to :role
  has_many :tickets
  has_many :blacklists

  #attr_accessor :password
  attr_accessible :login, :phone, :password, :password_confirmation, :email

  validates :login, :phone, :email, :presence => true
  validates :login, :uniqueness => true

  validates :password, :presence => true,
            :confirmation => true

  validates :password, :length => {:minimum => 6, :maximum => 40}


  #метод поиска пользователя
  def self.find_user(login, password)

    #получения хэш пароля
    @password = UserManagerHelper.decode_pass(password)
    @user = User.where(:login => login, :password => password)

    return @user
  end

end
