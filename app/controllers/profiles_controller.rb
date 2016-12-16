class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  
  
  def new
    @profile = Profile.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:notice] = "Profile updated"
      redirect_to user_path(id: params[:user_id])
    else
      render :new
    end
  end
  
  #GET '/users/:user_id/profile/edit'
  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end
  
  #PUT '/users/:user_id/profile'
  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile
    if @profile.update(profile_params)
      flash[:notice] = "Profile updated successfully"
      redirect_to user_path(@user) #id: @user.id
    else
      render :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find(params[:user_id])
      flash[:notice] = "Only profile owner can edit his/her profile"
      redirect_to root_path unless @user == current_user
    end
end