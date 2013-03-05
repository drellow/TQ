class QuestionsController < ApplicationController

  before_filter :admin_user, only: [:new, :edit, :update, :release]

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.all
  end

  def today
    @question = Question.todays_question
  end

  def release
    Question.todays_question.toggle!(:posted_answers)
    redirect_to admin_dashboard_path
  end

  def new
    if Question.todays_question.nil?
      @question = Question.new
    else
      @question = Question.todays_question
    end
  end

  def update
    Question.todays_question.update_attributes(params[:question])
    redirect_to root_path
  end

  def create
    question = current_user.questions.build(params[:question])

    if question.save
      User.all.each do |user|
        Notifier.email_question(user).deliver if user.receives_email
      end
      redirect_to root_path
    else
      render root_path
    end
  end
end
