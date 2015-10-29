class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if (params[:q] && params[:q] != "")
      @users = User.where ['name = ?', params[:q]]
    elsif current_user
      @users = User.where ['id != ?', current_user.id]
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user.number_of_answers = @user.answers.count
    @user.score = @user.answers.average(:rating)
    @user.best_answers = @user.answers.where(['best = ?', t]).count
    @user.save
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      redirect_to questions_path
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if auth && @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if auth
      log_out
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash.now.alert = 'Faça log in para alterar seu perfil'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :email_confirmation, :avatar, :about_me, :password, :password_confirmation)
  end

  def auth
    @user == current_user
  end
end
