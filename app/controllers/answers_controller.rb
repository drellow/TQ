class AnswersController < ApplicationController

  def new
    if current_user.answered_today?
      @answer = current_user.users_current_answer
      redirect_to root_url
    else
      @answer = Answer.new
      redirect_to root_url
    end
  end

  def create
    @answer = current_user.answers.build(params[:answer])

    if @answer.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def update
    current_user.users_current_answer.update_attributes(params[:answer])
    redirect_to root_url
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
      current_user.score -= 5
      current_user.save!
    end
    render :json => {
      answer_score: answer.score,
      user_score: current_user.score
    }
  end


end
