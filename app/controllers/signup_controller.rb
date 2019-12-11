class SignupController < ApplicationController

  def step1
    @user = User.new
    @profile = Profile.new
  end
  
  def step2
    @user = User.new(user_params)
    @profile = Profile.new(user_profile_params)
    if @user.save! && @profile.save!
      session[:email] = user_params[:email]
      session[:name] = user_params[:name]
      session[:family] = profile_params[:family]
      render 'signup/step3'
    else
      redirect_to action: 'step1'
    end
  end

  def step3
    @profile = Profile.new(profile_params)
    if @profile.valid?
    session[:number] = profile_params[:number]
    else
      redirect_to action: 'step2'
    end
  end

  def create
    @profile = Profile.new(profile_params)
    @user = User.new(
      name: session[:name]
    )
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email
    ).merge(password: 111111,password_confirmation: 111111)
  end

  def profile_params
    params.require(:profile).permit(
      :family,
      :number,
      :city
    )
  end

  def user_profile_params
    params.require(:user).require(:profile).permit(
      :family,
      :number,
      :city
    )
  end

end