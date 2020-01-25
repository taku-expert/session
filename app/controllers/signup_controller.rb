class SignupController < ApplicationController

  def index
    @users = User.all
    @profiles = Profile.all
  end

  def step1
    # step1.html.haml内のform_forで利用するためのインスタンス変数の作成
    @user = User.new
    @profile = Profile.new

    # この時点では@user,@profileはnewアクションで生成されただけの
    # 空のインスタンスなのでbinding.pryの結果は全て: nill
  end

  
  def step2
    # sessionの各キーへ代入
    session[:email] = user_params[:email]
    session[:name] = user_params[:name]
    session[:family] = user_profile_params[:family]

    # step2.html.haml内のform_forで利用するためのインスタンス変数の作成
    @profile = Profile.new
  end

  def step3
    # sessionの各キーへ代入
    session[:number] = profile_params[:number]

    # step3.html.haml内のform_forで利用するためのインスタンス変数の作成
    @profile = Profile.new
  end


  def create
    # sessionの各キーへ代入
    session[:city] = profile_params[:city]

    # sessionから保存すべきインスタンス変数へ再代入していく。
    @user = User.new(
      name: session[:name],
      email: session[:email],
      password: 111111,
      password_confirmation: 111111
    )
    @profile = Profile.new(
      family: session[:family],
      number: session[:number],
      city: session[:city]
    )
    # もし再代入されたものがバリデーションにひっかからなければ保存。
    if @user.valid? && @profile.valid?
      @user.save
      @profile.save
      redirect_to action: 'index'
    else
      # 保存できなかった(バリデーションにひかかった)場合は1ページ目からやり直し。
      redirect_to action: 'step1'
    end
  end

  def destroy
    profile = Profile.find(params[:id])
    user = User.find(params[:id])
    profile.destroy
    user.destroy
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
      :number,
      :city
    )
  end

  def user_profile_params
    params.require(:user).require(:profile).permit(
      :family
    )
  end

end