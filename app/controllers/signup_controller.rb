class SignupController < ApplicationController

  def step1
    @user = User.new
    @user.build_profile #userモデルとprofileモデルの関連付け。
  end
  
  def step2
    session[:user_params] = user_params  #userモデルの値をぶっこむ。
    session[:profile_attributes_after_step1] = user_params[:profile_attributes]  # profileモデルの値をぶっこむ。
    @user = User.new
    @user.build_profile
  end

  def step3
    session[:profile_attributes_after_step2] = user_params[:profile_attributes]  # step2で入力された情報をsessionにぶっこむ。
    session[:profile_attributes_after_step2].merge!(session[:profile_attributes_after_step1])  # step2のsessionにstep1のsessionの中身を合わせる。
    @user = User.new
    @user.build_profile
    binding.pry
  end

  def create
    @user = User.new(session[:user_params])  # ここでuserモデルのsessionを引数で渡す。
    @user.build_profile(session[:profile_attributes_after_step1])  # ここでprofileモデルのsessionを引数で渡す。
    @user.build_profile(user_params[:profile_attributes])  # 今回のビューで入力された情報を代入。
    binding.pry
    if @user.save
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
      :email,
      profile_attributes: [:id, :family, :number, :city]
    )
  end

end