class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = 'Invalid email/password combination' # flash.now works with render, flash does not
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

	private

		def redirect_signed_in_user
	      if signed_in?
	      	redirect_to root_path, notice: "You are already signed in."
	      end
	    end
end
