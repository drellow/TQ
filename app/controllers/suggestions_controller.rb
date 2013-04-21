class SuggestionsController < ApplicationController
  
  def index
    @suggestion = Suggestion.new
    @suggestions = Suggestion.order('created_at DESC').all
  end
  
  def create
    suggestion = current_user.suggestions.create(params[:suggestion])
    if suggestion.save
      current_user.score -= 50
      current_user.save!
    end
    redirect_to suggestions_path
  end
  
  def vote
    # It always costs the current user 5
    # points to vote either up or down.
    suggestion = Suggestion.find_by_id(params[:answer_id])
    if current_user.score >= 5
      if params[:score] == "up"
        suggestion.score += 5
        # I make sure the answer saves before updating user.
        if suggestion.save
          suggestion.user.legacy_score += 10
          suggestion.user.save!
        end
      else
        suggestion.score -= 5
        suggestion.save!
      end
      # Should eventually check if answer saves here too.
      # http://api.rubyonrails.org/classes/ActiveRecord/Transactions/ClassMethods.html
      current_user.score -= 5
      current_user.legacy_score += 1
      current_user.save!
    end
    render :json => {
      suggestion_score: suggestion.score,
      user_score: current_user.score
    }
  end
end
