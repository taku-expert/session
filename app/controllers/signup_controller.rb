class SignupController < ApplicationController

  def step1
    @user = User.new
    @profile = Profile.new
  end
  
  def step2
    @user = User.new(user_params)
    @profile = Profile.new(profile_params)
    if @user.valid? && @profile.valid?
      session[:email] = user_params[:email]
      session[:name] = user_params[:name]
      session[:family] = profile_params[:family]
      render 'step3'
    else
      redirect_to action: 'step1'
  end

  def step3
    @profile _ Profile.new
    session[:number] = user_params[:profile_attributes][:number]
    @user = User.new
    @user.build_profile
  end

  def create
    @profile _ Profile.new(profileparams)
    if  [pr]
    session[:city] = user_params[:profile_attributes][:city]
    @user = User.new(
      email: session[:email],
      name: session[:name]
      # family: session[:family],
      # number: session[:number],
      # city: session[:city]
    )
    binding.pry
    @user.build_profile(
      family: session[:family],
      number: session[:number],
      city: session[:city]
    )
    binding.pry
    if @user.save!
      binding.pry
      session[:id] = @user.id  #　ここでidをsessionに入れることでログイン状態に持っていける。
      redirect_to complete_signup_signup_index_path
    else
      render '/signup/step1'
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(
      :name,
      :email
    )
  end

  def profile_params
    params.require(:profile).permit(
      :id,
      :family,
      :number,
      :city
    )
  end

end