#coding:utf-8
class OrganizationManagerController < ApplicationController

	layout "security_layout"

	def new
		@organization = Organization.new
	end



	def create

		begin
			@organization = Organization.new(params[:organization])
			@organization.city_id=params[:city]

			if @organization.name.blank?
				raise "Поле наименование не может быть пустым!"
			elsif @organization.city_id.nil? or @organization.city_id == 0
				raise "Поле населенный пункт не может быть пустым!"
			elsif @organization.street.blank?
				raise "Поле улица не может быть пустым!"
			elsif @organization.number.nil?
				raise "Поле номер дома не может быть пустым!"
			end


			if @organization.save!
				flash[:success] = "Организация успешно сохранена!"
				redirect_to :doctor_edit
			end
		rescue => ex

			flash[:error] = ex.message
			redirect_to :organization_new
		end

	end



	def show
		if params[:id].nil?
			redirect_to root_path
			return
		end

		@id = params[:id].to_i
		@organization = Organization.find_by_id(@id)
		render :layout => "main_layout"
	end

end
