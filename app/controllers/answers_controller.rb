class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @myanswer = @question.answers.find_by(user_id: current_user.id)
    if @myanswer
      @myanswer.body = params[:answer][:body]
      @myanswer.save
      @myanswer.question.new_answers = true
      @myanswer.question.save
    else
      @answer = @question.answers.new(answer_params)
      @answer.user_id = current_user.id
      @answer.save
      @answer.question.new_answers = true
      @answer.question.save
    end
    flash.notice = "Resposta submetida"
    redirect_to question_path(@question)
  end

  def update
    @answer = Answer.find(params[:id])
    if params[:rating].size > 0
      @answer.rating = params[:rating]
    end
    if params[:best]
      @answer.best = params[:best]
      @answer.question.answers.where(['best = ?', true]).each do |answer|
        answer.best = false
        answer.save
      end
    end
    @answer.save
    redirect_to question_path(@answer.question)
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end
end
