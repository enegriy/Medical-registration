#coding:utf-8
class AdminController < ApplicationController

	include ActionView::Helpers::TagHelper

	def index
		if not check_admin
			flash[:error] = "Доступ к странице имеют только Администраторы!"
			redirect_to root_path
			return
		end

		render :layout => 'main_layout'
	end

	def runsql
		if not check_admin
			flash[:error] = "Доступ к странице имеют только Администраторы!"
			redirect_to root_path
			return
		end


		if params[:sql_text].nil?
			@sql_text = "Write sql text here..."
		else
			@error = "";
			@sql_text = params[:sql_text] 

			array_sql = @sql_text.to_s.split(';')

			begin
				result = nil
				ActiveRecord::Base.transaction do
					array_sql.each do |sql|
						connection = ActiveRecord::Base.connection()
						result = connection.execute(sql)
					end
				end
				@error = do_table result

			rescue =>ex
				@error = ex.message
			end
		end

		render :layout => 'main_layout'
	end



	private

	def check_admin
		is_admin = false;

		#Если пользователь не админ то шлем его на главную
		if not session[:user_id].blank?
			@user = User.find_by_id(session[:user_id].to_i)
			if @user.role_id == UserManagersHelper::IdRoles.admin
				is_admin = true
			end
		end

		return is_admin
	end


	def do_table(result)

		return "" if result.nil?

		table_body = ""

		row = ""
		for el in result.fields
			row += content_tag :td, el.to_s
		end

		table_body = content_tag :tr, row.html_safe

		for item in result
			row = ""
			for el in item
				row += content_tag :td, el.to_s 
			end
			table_body += content_tag :tr, row.html_safe
		end
		
		return content_tag(:table, table_body.html_safe)
	end

end
