class AnswersController < ApplicationController

  def new
    if current_user.answered_today?
      @answer = current_user.users_current_answer
      redirect_to root_url
    else
      # REV: huh? Shouldn't you display the form? If all you do is
      # redirect back, then remove this route?
      @answer = Answer.new
      redirect_to root_url
    end
  end

  def create
    # REV: can just write `if cur_user.answers.create(...`
    @answer = current_user.answers.build(params[:answer])

    if @answer.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def update
    # REV: update path embeds an update id, that's the Answer you
    # shoudl modify.
    current_user.users_current_answer.update_attributes(params[:answer])
    redirect_to root_url
  end

  def vote
    # REV: maybe write comments to document this method? People only
    # get to vote if they have a min score of 5? They add five points
    # to an answer, but ten to the user? I guess it costs me points to
    # vote someone else?
    if current_user.score >= 5
      # REV: what if you modify the user (legacy score), save him
      # successfully, but fail to save the answer itself? Or both
      # succeed but then current_user fails to save? This could happen
      # if a validation fails, if the DB goes down, if your app has a
      # bug and crashes...
      # http://api.rubyonrails.org/classes/ActiveRecord/Transactions/ClassMethods.html

      answer = Answer.find_by_id(params[:answer_id])
      if params[:score] == "up"
        answer.score += 5
        answer.user.legacy_score += 10
        answer.user.save!
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
