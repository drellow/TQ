class AnswersController < ApplicationController
  before_filter :admin_user, :only => [:admin_answers, :destroy]

  def new
    if current_user.answered_today?
      @answer = current_user.users_current_answer
    else
      @answer = Answer.new
    end
  end

  def admin_answers
    @answers = Question.todays_question.answers
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
      current_user.maybe_generate_feed_item
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
      elsif params[:score] == "down"
        answer.user.legacy_score -= 10
        answer.user.save!
        answer.score -= 5
        answer.save!
      end
      current_user.score -= 5
      current_user.legacy_score += 1
      current_user.save!
    end
    render :json => {
      answer_score: answer.score,
      user_score: current_user.score
    }
  end
end
