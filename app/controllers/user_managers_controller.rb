#coding:utf-8

class UserManagersController < ApplicationController


	#def index
	#	@users = User.all
	#end



	def new
		if not session[:user_id].nil?
			redirect_to root_path
			return
		end

		@user = User.new
		render :layout => 'spec_layout'
	end



	def create
		#debugger
		begin
			@user = User.new(params[:user])
			@user.role_id=params[:role_id]

			#Валидация логина
			#/^[a-zA-Z][a-zA-Z0-9]*$/ - маска только Латинские символы и цифры,начало с символа
			if not @user.login.nil?
				@login = @user.login.scan(/^[a-zA-Z][a-zA-Z0-9]*$/)
			else
				raise "Заполните поле Логин!"
			end

			if(@login.empty?)
				raise "Не правильное значение поля Логин! <br/>Значение должно начинаться с символа и содержать только латинские символы и цифры".html_safe
			end

			if not @user.password.blank?
				@user.password = UserManagersHelper.decode_pass(@user.password)
			else
				raise "Поле Пароль не может быть пустым"
			end

			if not @user.password_confirmation.blank?
				@user.password_confirmation = UserManagersHelper.decode_pass(@user.password_confirmation)
			end

			if @user.password != @user.password_confirmation
				raise "Поле пароль не совпадает, введите пароль ещё раз!"
			end

			if @user.email.blank?
				raise "Поле почтовый адрес должно быть заполнено!"
			elsif @user.email.scan(/^[\.\-_A-Za-z0-9]+?@[\.\-A-Za-z0-9]+?\.[A-Za-z0-9]{2,6}$/).empty?
				raise "Поле почтовый адрес указано не верно!"
			elsif not User.find_by_email(@user.email).blank?
				raise "Существует пользователь с таким почтовым адресом!"
			end

			if @user.role_id == 0
				raise "Неверно указана роль в системе!"
			end
			
			#Валидация введеного значения
			@result = params[:result].to_i
			@input_val = params[:input_val].to_i
			if @result != @input_val
				raise "Не правильно вычислено выражение! Повторите ещё раз!"
			end

			if params[:license] != "1"
				raise "Если вы не согласны с лицензионным соглашением пользование данным ресурсом запрещается!"
			end

			if(UserManagersHelper.is_doctor(@user.role_id))
				@doctor = Doctor.new
				if @doctor.save(:validate=>false)
					@user.doctor_id=@doctor.id
				else
					raise "Не удалось создать профиль врача, повторите регистрацию!"
				end

			end

			if @user.save!
				#логин
				session[:user_id] = @user.id
				session[:user_name] = @user.login

				#если пользователь вошел как врач то переходим сразу на страницу профиль
				if @user.role_id == UserManagersHelper::IdRoles.doctor
					flash[:notice] = "Заполните профиль"
					redirect_to :controller => :doctor_manager, :action=>:show
				else
					#переходим на главную страницу
					redirect_to root_path
				end
				
				SendMail.welcome_email(@user).deliver
			end

		rescue =>ex
			flash[:error] = ex.message
			render  :layout=>'spec_layout',:action => '/new'
		end


	end



	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to :action=>:index
			flash[:success] = "Пользователь успешно удален!"
		else
			flash[:error] = @user.errors.messages
			redirect_to :action=>:index
		end
	end



	def edit
		@user = User.find(params[:id])
		render :layout => 'spec_layout'
	end



	def update
		@user = User.find(params[:user_id])
		@user.update_attributes(params[:user])
		if @user.save
			redirect_to :action=>:index
			flash[:success] = "Изменения сохранены!"
		else
			flash[:error] = @user.errors.messages
			redirect_to :action=>:edit
		end
	end



	def login

		if params[:login].empty?
			flash[:error] = "Заполните поле Логин!"
		elsif params[:password].empty?
			flash[:error] = "Заполните поле Пароль!"
		else
			@user = User.where("(login = ? or email = ?) and password = ?",params[:login],params[:login],UserManagersHelper.decode_pass(params[:password]))

			if not @user.empty?
				session[:user_id] = @user.first.id
				session[:user_name] = @user.first.login
			else
				flash[:error] = "Пользователь не найден!"
			end
		end

		if not (params[:controller_name].blank? and params[:action_name].blank?)
			redirect_to :controller=>params[:controller_name],
									:action=>params[:action_name]
		else
			redirect_to root_path
		end

	end



	def logout
		session.delete(:user_id)
		redirect_to root_path
	end

	def form_restore
		render :layout => 'main_layout'
	end

	def restore_pass
		begin
			@email = params[:email]

			@user = User.find_by_email(@email)
			if @user.blank?
				raise "Не найден пользователь с таким почтовым адресом!"
			end

			@new_pass = UserManagersHelper.gen_pass
			UserManagersHelper.update_pass(@user, @new_pass)
			SendMail.restore_pass(@user, @new_pass).deliver

			redirect_to root_path
			flash[:success] = "Вам на почту выслан новый пароль!"
		rescue => ex
			flash[:error] = "Ошибка при восстановлении пароля! "+ex.message

			redirect_to :action=>:form_restore
		end

	end

	def license
		render :layout => 'main_layout'
	end


end

