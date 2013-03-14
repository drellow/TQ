class AnswersController < ApplicationController

  def new
    if current_user.answered_today?
      @answer = current_user.users_current_answer
    else
      @answer = Answer.new
    end
  end

  def destroy
    Answer.find(params[:id]).destroy
    redirect_to admin_answers_path
  end

  def create
    if current_user.answers.create(params[:answer])
      current_user.score += 50
      current_user.legacy_score += 50
      current_user.save!
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
    # It always costs the current user 5
    # points to vote either up or down.
    answer = Answer.find_by_id(params[:answer_id])
    if current_user.score >= 5
      if params[:score] == "up"
        answer.score += 5
        # I make sure the answer saves before updating user.
        if answer.save
          answer.user.legacy_score += 10
          answer.user.save!
        end
      else
        answer.score -= 5
        answer.save!
      end
      # Should eventually check if answer saves here too.
      # http://api.rubyonrails.org/classes/ActiveRecord/Transactions/ClassMethods.html
      current_user.score -= 5
      current_user.save!
    end
    render :json => {
      answer_score: answer.score,
      user_score: current_user.score
    }
  end
end
