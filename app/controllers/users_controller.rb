class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}

  def index
    @users = User.all
  end

  def login_form
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password]
    )
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザーを作成しました"
      redirect_to(user_path(@user))
    else
      render "new"
    end
  end

  def login
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to(user_path(user))
    else #既存パタン
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:notice] = "ログインしました"
        redirect_to(user_path(@user))
      else
        @error_message = "メールアドレスまたはパスワードが間違っています"
        @email = params[:email]
        @password = params[:password]
        render("users/login_form")
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to(login_path)
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
