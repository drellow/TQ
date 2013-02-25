class AnswersController < ApplicationController

  def new
    @answer = users_current_answer
    puts "-------------------------"
    puts users_current_answer

  end

  def create
    puts params
    @answer = @current_user.answers.build(params[:answer])

    if @answer.save
      redirect_to '/'
    else
      puts "BAD BAD BAD"
      redirect_to '/'
    end
  end



end
