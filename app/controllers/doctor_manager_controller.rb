#coding:utf-8



class DoctorManagerController < ApplicationController


	def edit
		@doctor = DoctorManagerHelper.get_doctor(session[:user_id])

		if @doctor.nil?
			redirect_to root_path
			flash[:error] = 'Не правильно определен профиль врача! Переавторизуйтесь!'
		else

			if @doctor.birth_date.nil?
				@doctor.birth_date = Date.new(1980,1,1)
			end

			render :layout => 'security_layout'
		end
	end



	def save
		@doctor = Doctor.find(params[:doctor_id])
		@doctor.update_attributes(params[:doctor])

		@doctor.birth_date=Date.civil(params[:birth_date][:year].to_i, params[:birth_date][:month].to_i, params[:birth_date][:day].to_i)

		if @doctor.save
			flash[:success] = "Изменения сохранены!"
			redirect_to :action=>:show
		else
			flash[:error] = ApplicationHelper.error_to_html (@doctor.errors.messages)
			redirect_to :action=>:edit
		end

	end



	def show
		@doctor = DoctorManagerHelper.get_doctor(session[:user_id])
		if @doctor.nil?
			redirect_to root_path
			flash[:error] = 'Не правильно определен профиль врача! Переавторизуйтесь!'
		else
			render :layout => 'security_layout'
		end
	end



	def add_photo
		@doctor = DoctorManagerHelper.get_doctor(session[:user_id])
		if @doctor.nil?
			redirect_to root_path
			flash[:error] = 'Не правильно определен профиль врача! Переавторизуйтесь!'
		else
			render :layout => 'security_layout'
		end
	end



	def upload

		uploaded_io = params[:picture]

		if uploaded_io.nil?
			flash[:error] = "Выберите изображение!"
			redirect_to :action=>:add_photo
			return
		end

		upload_file = DoctorManagerHelper.generate_photo_name+".jpeg"

		if (not uploaded_io.nil?) && uploaded_io.content_type == 'image/jpeg'

			File.open(Rails.root.join('public', 'uploads', upload_file), 'wb') do |file|

				file.write(uploaded_io.read())

				if file.size > (512*1024)
					file.close
					File.delete(file)
					flash[:error] = "Файл не должен превышать размер 500 килобайт!"
					redirect_to :action=>:add_photo
					return
				end

				DoctorManagerHelper.set_photo(session[:user_id],upload_file)
			end


			redirect_to :action=>:show
		else
			flash[:error] = "Файл должен быть типа JPEG!"
			redirect_to :action=>:add_photo
		end

	end
	
	def profile
		if params[:id].nil?
			redirect_to root_path
			return
		end
		
		@doctor = Doctor.find(params[:id].to_i)
		render :layout => 'main_layout'
	end



end
