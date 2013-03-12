class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def seller
      @user = current_user
      return @user.seller
    end
    helper_method :seller

  	def current_user
      if @current_user
        @current_user 
      else
        @current_user = User.where(:id => session[:user_id]).first if session[:user_id]
        if @current_user.nil?
          @current_user = User.create(:first_name => "Guest", :temp => true)
        end
        session[:user_id] = @current_user.id
        @current_user
      end
    end

  	helper_method :current_user

  	def authorize
  		redirect_to login_url, alert: "Not Authorized" if !current_user.seller	
  	end

	def current_cart 
    if @current_cart
        @current_cart
    else

      @current_cart = Cart.order("id DESC").where(:user_id => session[:user_id], :active => true).first if session[:cart_id]
      if @current_cart.nil?
        @current_cart = Cart.create(:user_id => session[:user_id], :active => true)
      end
      session[:cart_id] = @current_cart.id
      @current_cart
    end
  end

  helper_method :current_cart
end
