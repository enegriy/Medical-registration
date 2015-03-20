#coding:utf-8

class TicketManagerController < ApplicationController


	def new
		@ticket = Ticket.new
		@ticket.visit_date=Time.at(ApplicationHelper.get_param(params[:visit_date]).to_i)
		@ticket.doctor_id=ApplicationHelper.get_param(params[:doctor_id])
		@ticket.user_id=session[:user_id]

		@doctor = Doctor.find(@ticket.doctor_id)

		render :layout => "security_layout"

	end



	def create
		@ticket = Ticket.new(params[:ticket])
		isSuccess = true

		ActiveRecord::Base.transaction do

			@tiket_is_exist = Ticket.where(:visit_date => @ticket.visit_date, :doctor_id => @ticket.doctor_id)
			if @tiket_is_exist.count > 0

				ActiveRecord::Rollback
				flash[:error] = "Извините на выбранное вами время уже была произведена запись, попытайтесь записаться вновь!"
				isSuccess = false
			elsif  @ticket.save
				flash[:success] = "Вы успешно записались на прием!"
			else

				flash[:error] = "Ошибка сохранения приема!"
				isSuccess = false
			end
		end

		if isSuccess 
			redirect_to :personal_room_index
		else
			redirect_to timegrid_path(@ticket.doctor_id)
		end

	end



	def delete

		if not params[:id].nil?
			@ticket = Ticket.find(params[:id])
			@ticket.destroy
		end

		redirect_to :controller => :personal_room, :action => :index
	end



	def delete_collections
		@tickets = params[:tickets]

		@tickets.each do |t|
			ticket = Ticket.find(t)
			ticket.destroy
		end

		redirect_to :controller => :timetable, :action => :show
	end



	def list_tickets
		user_id=session[:user_id]
		@doctor_id = DoctorManagerHelper.get_doctor(user_id)

		on_date = Date.current

		if not params[:on_date].nil?
			on_date = date_civil(params[:on_date]['date(1i)'].to_i, params[:on_date]['date(2i)'].to_i, params[:on_date]['date(3i)'].to_i)
		end

		@tickets = Ticket.where("doctor_id=:doctor and cast(visit_date as date) = :date",
									:doctor => @doctor_id, :date => on_date ).order("visit_date")

		@all_tickets = Ticket.where("cast(visit_date as date) > '#{Date.current}' and doctor_id=#{@doctor_id.id}").order("visit_date")

		@date_for_control = {
				:day=>on_date.day,
				:month=>on_date.month,
				:year=>on_date.year
		}

		render :layout => "security_layout"

	end

	def show
		@ticket = Ticket.find_by_id(params[:id].to_i)
		@doctor = @ticket.doctor
	end

	private
	def date_civil(year, month, day)
		on_date = nil
		begin
			on_date = Date.civil(year, month, day)
		rescue 
			on_date = Date.civil(year, month, Date.new(year,month,1).end_of_month.strftime("%d").to_i)
		end

		on_date
	end

end
