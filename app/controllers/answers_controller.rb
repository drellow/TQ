class AnswersController < ApplicationController

  def new
    if current_user.answered_today?
      @answer = current_user.users_current_answer
      redirect_to '/'
    else
      @answer = Answer.new
      redirect_to '/'
    end
  end

  def create
    @answer = current_user.answers.build(params[:answer])

    if @answer.save
      redirect_to '/'
    else
      redirect_to '/'
    end
  end

  def update
    current_user.users_current_answer.update_attributes(params[:answer])
    redirect_to '/'
  end
end
