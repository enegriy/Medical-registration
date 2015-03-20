#coding:utf-8

module UserManagersHelper

	def self.get_roles_by_user(session)
		@content_select = [["",0]]

		#Если пользователь админ
		if not session[:user_id].nil?
			if @user.role_id == UserManagersHelper::IdRoles.admin
				@content_select += Role.where("roles.id <> ?",@user.role_id).map { |role| [role.name, role.id] }
			end
		end

		#Если пользователь не авторизован(или он не админ) то он может зарегистрироваться как пользователь
		if session[:user_id].nil? or @content_select == nil
			#@content_select = Role.where("roles.id = ?",UserManagerHelper::IdRoles.user).map { |role| [role.name, role.id] }
			@content_select += Role.where("roles.id in (2,3)").map { |role| [role.name, role.id] }
		end

		@content_select
	end

	#функция преобразования текста в хэш
	def self.decode_pass(password)
		noise = "xdf4s-dffh-dfgd-gdvb-4fd53-fdrtg-34w3d-fgfd4"
		::Digest::MD5.hexdigest(password + noise)
	end



	#Фукция определения врача
	def self.is_doctor(role_id)
		rslt = false
		@role = Role.where(:id=>role_id)
		if(@role.count > 0 && @role.first().name == ValueRoles.doctor)
			rslt = true
		end
		rslt
	end



	#Фукция определения администратора
	def self.is_admin(role_id)
		rslt = false
		@role = Role.where(:id=>role_id)
		if(@role.count > 0 && @role.first().name == ValueRoles.admin)
			rslt = true
		end
		rslt
	end



	#Фукция определения по пользователю
	def self.is_doctor_byuser(user_id)
		@user = User.find(user_id)
		is_doctor(@user.role_id)
	end



	#Получить ид доктора по ид пользователя
	def self.get_doctor_byuser(user_id)
		@user = User.find(user_id)
		@user.doctor_id
	end



	#Класс значений ролей, используется для определения роли пользователя
	class ValueRoles
		@admin = "Администратор"
		@doctor = "Врач"
		@user = "Пользователь"

		def self.admin
			@admin
		end

		def self.doctor
			@doctor
		end

		def self.user
			@user
		end
	end

	class IdRoles
		@admin  = 1
		@doctor = 2
		@user   = 3

		def self.admin
			@admin
		end

		def self.doctor
			@doctor
		end

		def self.user
			@user
		end
	end

	def self.gen_pass
		symbols = "qwertyuiopasdfghjklzxcvbnm123456778890"
		rslt = ""
		6.times do 
			rslt += symbols[Random.rand(symbols.length)]
		end
		rslt
	end

	def self.update_pass(user,pass)
		user.password = decode_pass(pass)
		user.save!
	end


end

