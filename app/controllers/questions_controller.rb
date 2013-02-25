class QuestionsController < ApplicationController

  before_filter :admin_user, only: [:new, :edit, :update]

  def show
  end

  def index
  end

  def today
    @question = todays_question
  end


  def new
    if todays_question.nil?
      @question = Question.new
    else
      @question = todays_question
    end
  end

  def update
    todays_question.update_attributes(params[:question])
    redirect_to root_path
  end

  def create
    question = @current_user.questions.build(params[:question])

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

    def todays_question
      Question.where('created_at BETWEEN ? AND ?',
      DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
    end
end
