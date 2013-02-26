class QuestionsController < ApplicationController

  before_filter :admin_user, only: [:new, :edit, :update, :release]

  def show
  end

  def index
  end

  def today
    @question = Question.todays_question
  end

  def release
    Question.todays_question.toggle!(:posted_answers)
    redirect_to '/'
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
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
