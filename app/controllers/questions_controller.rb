class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :answer_this]

  def index
    @questions = Question.where ['user_id != ?', current_user.id]
    @my_questions = Question.where ['user_id == ?', current_user.id]
  end

  def show
    @answers = Answer.where ['question_id == ?', @question.id]
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(user_params)
    @question.user_id = current_user.id

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if auth && @question.update(user_params)
      redirect_to @question, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if auth
      @question.destroy
      redirect_to controller: 'questions'
    else
      flash.now.alert = 'Permissão negada'
    end
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def user_params
    params.require(:question).permit(:title, :body)
  end

  def auth
    @question.user_id == current_user.id
  end
end
