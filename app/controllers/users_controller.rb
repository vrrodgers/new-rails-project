class UsersController < ApplicationController
  def index
    @user = User.new
    UserMailer.example(User.new(email: 'bo@samurails.com')).deliver
    @users = User.all
  end

   def create
     @user = User.new
     @user.name = params[:user][:name]
     @user.email = params[:user][:email]
     @user.password = params[:user][:password]
     @user.password_confirmation = params[:user][:password_confirmation]

     if @user.save
       flash[:notice] = "Welcome to Blocipedia #{@user.name}!"
       redirect_to root_path
     else
       flash.now[:alert] = "There was an error creating your account. Please try again."
       render :new
     end
   end

  def new
    @user = User.new
  end


  def edit
  end
end
