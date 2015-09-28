class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id
    @answer.save
    @answer.user.number_of_answers = Answer.where(user_id: @answer.user.id).count
    @answer.user.save

    redirect_to question_path(@question)
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.rating = params[:rating]
    @answer.save
    user = @answer.user
    user.score = Answer.where(user_id: user.id).average(:rating)
    user.save
    redirect_to question_path(@answer.question)
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end
end
