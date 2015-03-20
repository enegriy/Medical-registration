#coding:utf-8
class PersonalRoomController < ApplicationController


	def index
		@user_id = session[:user_id].to_i

		@tickets = Ticket.where("user_id = ? and visit_date > ?", @user_id, DateTime.current.to_s).order("visit_date DESC")

		render :layout => "security_layout"
		
	end


	def history
		@user_id = session[:user_id].to_i
		@tickets_old = Ticket.where("user_id = ? and visit_date < ? and visit_date > ?",
								@user_id, DateTime.current.to_s,(DateTime.current-180).to_s).order("visit_date DESC")

		render :layout => "security_layout"
	end


	def edit_user
		@user_id = session[:user_id].to_i
		@user = User.find_by_id(@user_id)

		@isDoctor = UserManagersHelper.is_doctor(@user.role_id);
		
		@is_send_visits = false;
		
		if @isDoctor
			doctor = Doctor.find_by_id(@user.doctor_id);
			@is_send_visits = doctor.is_send_visits
		end

		render :layout => "security_layout"
	end

	def update
		@user = User.find(params[:user_id].to_i)
		@isDoctor = UserManagersHelper.is_doctor(@user.role_id);

		is_send_visits = params[:is_send_visits]

		begin
			@user.update_attributes(params[:user])
			@user.save!
			
			if @isDoctor
				doctor = Doctor.find_by_id(@user.doctor_id)
				doctor.is_send_visits = is_send_visits
				doctor.save!
			end

			flash[:success]="Сохранение данных завершилось успехом!"
		rescue =>ex
			flash[:error] = "Ошибка сохранения, поля помеченные звездочкой обязательные для заполнения!"
		end

		redirect_to :action => "edit_user", :user_id => params[:user_id].to_i 
	end


end
