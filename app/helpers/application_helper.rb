#coding:utf-8

module ApplicationHelper

  @words = ["or","and","select",";","script","where","delete","update","'","--"]

  def self.get_param(_param)

    @words.each do |word|
      _param.to_s.gsub(word,"")
    end

    _param

  end

  #Функция преобразующая текст ошибки в html
  def self.error_to_html( error )
    array_messages = []
    result = ""

    error.keys.each do |key|
      message=""

      if Fields.has_key?(key.to_s)
        message = "Поле «" + Fields[key.to_s] + "» ";
        if ErrorMessages.has_key?(error[key][0])
          message += ErrorMessages[error[key][0]]
        else
          message += error[key][0]
        end
      end

      if message == ""
        array_messages.append error[key].to_s
      else
        array_messages.append message
      end

    end

    array_messages.each do |mes|
      result += "<li>"+mes+"</li>"
    end

    result = "<ul>"+result+"<ul>"
    result.html_safe
  end


  private
  #поля
  Fields =
      {
          "login"=>"Логин",
          "password"=>"Пароль",
          "phone"=>"Телефон",
          "soname"=>"Фамилия",
          "name"=>"Имя",
          "birth_date"=>"Дата рождения",
          "spec_id"=>"Специальность",
          "work_phone"=>"Рабочий телефон",
          "organization_id"=>"Организация"

      }
  #сообщения
  ErrorMessages =
      {
          "can't be blank"=>"не может быть пустым",
          "has already been taken"=>", значение этого поля уже существует, введите новое значение",
          "doesn't match confirmation"=>"не совпадает, введите ещё раз"
      }

end
