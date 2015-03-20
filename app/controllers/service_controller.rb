#coding:utf-8

class ServiceController < ApplicationController

	
	def get_cities
		if params[:region].nil?
			return ""
		end

		@cities = City.where(:region_id => params[:region]).select("name,id")
		@rslt = @cities.to_json.html_safe

	end

		
	def get_organizations
		if params[:city].nil?
			return ""
		end

		@orgs = Organization.where(:city_id =>  params[:city]).select("name,id")
		@rslt = @orgs.to_json.html_safe

	end


	def send_visits
		@date = Date.current
		@doctors = Doctor.where("doctors.is_send_visits = ? and doctors.old_date_sendvisits < ?", true, @date)

		@count = @doctors.count

		@doctors.each do |d|
			ActiveRecord::Base.transaction do
				tickets = Ticket.where("cast(visit_date as date) = '#{@date}' and doctor_id=#{d.id}").order("visit_date")
				SendMail.send_visits(d,tickets).deliver
				d.old_date_sendvisits = @date
				d.save!
			end
		end

	end


	def get_license
	end
		
end
