class TimegridController < ApplicationController


	def index
		if params[:id].nil?
			redirect_to root_path
			return
		end

		@id = params[:id]

		#Принимаем номер недели
		begin
			@week = params[:week].to_i
			if @week != 2
				@week = 1
			end
		rescue
			@week = 1
		end

		#Дата
		@date =
				@week == 1 ?
				DateTime.current :
				DateTime.current+7

		Time::DATE_FORMATS[:ru_datetime] = "%d%M"
		@start_week = (@date).monday
		@doctor_id = ApplicationHelper.get_param(params[:id])
		@doctor = Doctor.find(@doctor_id)
		render :layout => 'main_layout'
	end


end
