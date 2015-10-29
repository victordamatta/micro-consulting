class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @myanswer = @question.answers.find_by(user_id: current_user.id)
    @answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      if @myanswer
        current_user.answers.destroy(@myanswer)
      end
      flash.notice = "Resposta submetida"
    end
    redirect_to question_path(@question)
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.rating = params[:rating]
    @answer.best = !!params[:best]
    @answer.save
    redirect_to question_path(@answer.question)
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end
end
