class MainpageController < ApplicationController

	require "will_paginate"

	def index

		if params[:mode] == "apply"
			@region = recive_param(params[:filter_region].to_i)
			@city = recive_param(params[:filter_city].to_i)
			@spec = recive_param(params[:spec].to_i)
			@org = recive_param(params[:org].to_i)

			set_cookie(:filter_region, @region)
			set_cookie(:filter_city, @city)
			set_cookie(:spec, @spec)
			set_cookie(:org, @org)

		else
			@region = recive_param(cookies[:filter_region].to_i)
			@city = recive_param(cookies[:filter_city].to_i)
			@spec = recive_param(cookies[:spec].to_i)
			@org = recive_param(cookies[:org].to_i)
		end

		#находим себя
		@myself = find_me(session[:user_id]) 

		#формируем условия для выбора врачей
		clause = "doctors.soname is not null"

		if not @myself.nil?
			clause += " and doctors.id <> #{@myself.id}"
		end

		if not @spec.nil?
			clause += " and doctors.spec_id = "+@spec.to_s
		end

		if not @org.nil?
			clause += " and doctors.organization_id = "+@org.to_s
		end

		if not @city.nil?

			clause += " and organizations.city_id = "+@city.to_s
			@doctors = Doctor.joins('inner join organizations on doctors.organization_id = organizations.id').where(clause).paginate(:page => params[:page]).order("doctors.soname, doctors.name").to_a
		
		elsif not @region.nil?
			@ids = Doctor.find_by_sql("select doctors.id from doctors
				inner join organizations o on doctors.organization_id = o.id 
				inner join cities c on o.city_id = c.id
				where c.region_id = #{@region} and #{clause}
				order by doctors.soname, doctors.name;")

			if @ids == []
				@doctors = []
			else
				@str_id = @ids.map{|r| r["id"]}.join(",")
				@doctors = Doctor.where("doctors.id in (#{@str_id}) ").paginate(:page => params[:page]).order("doctors.soname, doctors.name")
			end

		else

			@doctors = Doctor.where(clause).paginate(:page => params[:page]).order("doctors.soname, doctors.name")
		
		end
		

		#рендерим
		render :layout => 'main_filters_layout'
	end


	protected

	#принимаем параметры
	def recive_param(param_field)
		if not param_field.nil? and param_field != ""  and param_field != 0
			begin
				ApplicationHelper.get_param(param_field).to_i
			rescue
				nil
			end
		end
	end

	#Наити себя
	def find_me(user)

		rslt = nil

		if not user.nil? and User.find_by_id(user).role.id == UserManagersHelper::IdRoles.doctor 
			rslt = Doctor.find_by_id(User.find_by_id(user).doctor_id)
		end

		#Если профиль не заполнен
		if ((not rslt.nil?) and (rslt.soname.nil?))
			rslt = nil
		end

		rslt

	end

	#Установить куки
	def set_cookie(name, value)
		cookies[name] = {:value=>value, :expires=>30.days.from_now}
	end


end
