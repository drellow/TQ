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

  def vote
    if current_user.score >= 5
      answer = Answer.find_by_id(params[:answer_id])
      if params[:score] == "up"
        answer.score += 5
        answer.save!
      else
        answer.score -= 5
        answer.save!
      end
      current_user.decrement_score
    else
      return false
    end
    render nothing: true
  end


end
