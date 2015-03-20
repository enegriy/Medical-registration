#coding:utf-8
class TimetablesController < ApplicationController

	def index
		doctor_id = UserManagersHelper.get_doctor_byuser(session[:user_id])

		@timetables = Timetable
			.where(:doctor_id=>doctor_id)
			.order("dayofweek_id, time_for")

		@doctor_absence = DoctorAbsence.where("doctor_id = :doctor and absence_date >= :date",
																					 :doctor=>doctor_id, :date=>Date.current.to_s("%Y-%m-%d")).order("absence_date")

		render :layout => 'security_layout'
	end

	def new
		@timetable = Timetable.new

		#Значения по умолчанию
		@timetable.time_for = Time.parse("08:00")
		@timetable.time_to = Time.parse("09:00")
		@timetable.time_of_visit = 15

		render :layout => 'security_layout'
	end



	def create
		@timetable = Timetable.new(params[:timetable])

		@timetable.daytype_id=params[:daytype_id]
		@timetable.dayofweek_id=params[:dayofweek_id]

		@timetable.doctor_id= UserManagersHelper.get_doctor_byuser(session[:user_id])

		if not @timetable.save
			flash[:error] = @timetable.errors.full_messages
			render :layout=>'security_layout',:action => '/new'
		else
			redirect_to '/timetables'
		end


	end



	def edit
		@timetable = Timetable.find(params[:id])
		render :layout => 'security_layout'
	end



	def update
		doctor_id = UserManagersHelper.get_doctor_byuser(session[:user_id])

		@timetable = Timetable.find(params[:timetable_id])
		@timetable.update_attributes(params[:timetable])

		@timetable.daytype_id = params[:daytype_id]
		@timetable.dayofweek_id = params[:dayofweek_id]

		#получаем список записей на ближайшее время на которое изменилось расписание
		@tickets = TimetablesHelper.get_tickets_more_date(doctor_id,Date.current,params[:dayofweek_id])

		if @tickets.count == 0
			if @timetable.save
				redirect_to '/timetables'
				flash[:success] = "Изменения сохранены!"
			else
				flash[:error] = @timetable.errors.full_messages
				render :layout=>'security_layout',:action => '/edit'
			end
		else
			render :layout => 'security_layout'
		end

	end



	def destroy
		@timetable = Timetable.find(params[:id])
		if @timetable.destroy
			flash[:success] = "Расписание удалено!"
		else
			flash[:error] = @timetable.errors.messages
		end

		redirect_to '/timetables'
	end



	def add_absence
		@doctor_absence = DoctorAbsence.new
		@doctor_absence.doctor_id=UserManagersHelper.get_doctor_byuser(session[:user_id])

		render :layout => 'security_layout'
	end



	def save_absence

		@doctor_absence = DoctorAbsence.new(params[:doctor_absence])
		@doctor_absence.absence_date=DateTime.civil(params[:absence_date]['date(1i)'].to_i, params[:absence_date]['date(2i)'].to_i, params[:absence_date]['date(3i)'].to_i)

		if @doctor_absence.save
			flash[:success] = "Причина отсутствия сохранена!"
		else
			flash[:error] = "Ошибка сохрания причины отсутствия!"
		end
		redirect_to '/timetables'

	end



	def del_absence

		@doctor_absence = DoctorAbsence.find(params[:id])
		if @doctor_absence.destroy
			flash[:success] = "Причина отсутствия удалена!"
		else
			flash[:error] = "Ошибка удаления причины отсутствия!"
		end
		redirect_to '/timetables'

	end


end
