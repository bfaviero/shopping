class SessionsController < ApplicationController
	def new
	end

	def create
	  	  @old_cart =   Cart.find(:first, :conditions => [ "id = ?", session[:cart_id]])
		  @user = User.find_by_email(params[:email])
		  if @user && @user.authenticate(params[:password])
		    session[:user_id] = @user.id
		    @cart = current_cart
		    session[:cart_id] = @cart.id
		    if @old_cart.get_total_items>0
		    	@cart.merge(@old_cart)
		    end
		    redirect_to root_url, notice: "Logged in!"
		  else
		    flash.now.alert = "Email or password is invalid"
		    render "new"
		  end
		end

	def destroy
	  session[:user_id] = nil
	  session[:cart_id] = nil
	  redirect_to root_url, notice: "Logged out!"
	end

end
