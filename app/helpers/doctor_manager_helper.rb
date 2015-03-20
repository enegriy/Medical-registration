module DoctorManagerHelper

  #Костанты для хэлпера
  Path = "public/uploads/"
  DefaualtPhoto = "default.png"

  # @param doctor [Doctor]
  def self.get_region(doctor)
    if not doctor.nil? and
        not doctor.organization.nil? and
        not doctor.organization.city.nil? and
        not doctor.organization.city.region.nil?
      doctor.organization.city.region.id
    else
      0
    end
  end

  # @param doctor [Doctor]
  def self.get_city(doctor)
    if not doctor.nil? and
        not doctor.organization.nil? and
        not doctor.organization.city.nil?
      doctor.organization.city.id
    else
      0
    end
  end

  # @param doctor [Doctor]
  def self.get_organization(doctor)
    if not doctor.nil? and
        not doctor.organization.nil?
      doctor.organization.id
    else
      0
    end
  end

  #Получить значение поля, если nil то '' иначе значение
  def self.get_value(field)
    @rslt = ''
    if not field.nil?
      @rslt = field.to_s
    end
    @rslt
  end


  #Получить количество лет
  def self.get_year_old(date)
    if not date.nil?
      Date.current.year - date.year
    else
      0
    end
  end


  #Получить номер телефона зарегистрированного пользователя
  def self.get_phone(doctor_id)
    if(not doctor_id.nil?)
      @users = User.where(:doctor_id => doctor_id)
      @user = @users.first()
      @user.phone
    else
      ""
    end
  end


  #Установить имя нового фото для фрача и удалить старое
  def self.set_photo(user_id,photo_path)
    @doctor = get_doctor(user_id)
    if not @doctor.nil?

      delete_photo(@doctor.photo_path)
      @doctor.photo_path=photo_path
      @doctor.position_photo=get_position(photo_path)

      @doctor.save(:validate=>false)
    end
  end


  #Удалить фото
  def self.delete_photo(photo_name)
    if photo_name.nil? or photo_name != DefaualtPhoto
      begin
        File.delete(Path+photo_name)
      rescue
      end
    end
  end


  #Получить объект доктор
  def self.get_doctor(user_id)
    @doctor = nil
    if not user_id.nil?
      @user = User.find(user_id)
      if not @user.doctor_id.nil?
        @doctor = Doctor.find(@user.doctor_id)
      end
    end
    @doctor
  end


  #Получить путь к фото
  def self.get_photo_path(doctor)
    @path = "/uploads/"
    if doctor.photo_path.nil?
      @path += DefaualtPhoto
    else
      @path += doctor.photo_path
    end
    @path
  end


  #Получить ФИО одной строкой
  def self.get_fio(doctor)

    rslt = DoctorManagerHelper.get_value(doctor.soname)+" "+
           DoctorManagerHelper.get_value(doctor.name)+" "+
           DoctorManagerHelper.get_value(doctor.second_name)

  end


  #Загружаемое изображение горизонтальное
  def self.IsHorizont(file)

    isHorz = false

    geo = Paperclip::Geometry.from_file(file)
    if geo.width > geo.height
      isHorz = true
    end

    isHorz
  end

  #Получить позицию вериткальное или горизонтальное
  def self.get_position(file_name)
    file_path = Path+file_name
    rsltIsHorz = IsHorizont(file_path)
    if rsltIsHorz
      "h"
    else
      "v"
    end
  end


  #Сгенерировать имя для изображения
  def self.generate_photo_name()
    photo_name = (0..32).to_a.map{|a| rand(32).to_s(32)}.join
    return photo_name.to_s
  end


  #Обрезать профиль
  def self.show_note(note, doctor_id, link)
    if(note.length > 200)
      return note.slice(0..200)+'...<br/>'+link
    end
    return note
  end

end
