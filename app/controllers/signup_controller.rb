class SignupController < ApplicationController

  def step1
    @user = User.new
    @profile = Profile.new
  end
  
  def step2
    @profile = Profile.new(profile_params)
    if @user.save! && @profile.save!
      session[:email] = user_params[:email]
      session[:name] = user_params[:name]
      session[:family] = profile_params[:family]
      render 'step3'
    else
      redirect_to action: 'step1'
    end
  end

  def step3
    @profile = Profile.new(profile_params)
    # if @profile.valid?
    #   session[:number] = profile_params[:number]
    # else
    #   redirect_to action: 'step2'
    # end
  end

  def create
    @user = User.new(
      family: session
    )
    @profile = Profile.new(profile_params)
    if @profile.valid?
      session[:city] = profile_params[:city]
      @user = User.new(
        email: session[:email],
        name: session[:name]
      )
      @profile = Profile.new(
        family: session[:family],
        number: session[:number],
        city: session[:city]
      )
      @user.save
      @profile.save
      redirect_to complete_signup_signup_index_path
    else
      render '/signup/step1'
    end
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
  params.require(:user).require(:profile).permit(
    :family,
    :number,
    :city
  )
end