#coding:utf-8
class SendMail < ActionMailer::Base
  default from: "negriy.evgeniy@gmail.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Добро пожаловать на www.k-docto.ru!")
  end

  def restore_pass(user,pass)
  	@user = user
  	@pass = pass
  	
  	mail(:to => user.email, :subject => "Восстановление пароля www.k-docto.ru")
  end

  def send_visits(doctor,visits)
    @user = User.where(:doctor_id=>doctor.id).first()
    @visits = visits

    if not @user.nil?
      mail(:to=>@user.email, :subject => "Список записавшихся пациентов на #{Date.current.strftime("%d.%m.%Y")}")
    end
  end
end
