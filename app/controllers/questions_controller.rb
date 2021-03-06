class QuestionsController < ApplicationController

  before_filter :admin_user, only: [:new, :edit, :update, :release]

  def show
    @question = Question.find(params[:id])
    if @question == Question.todays_question && !Question.todays_answers_posted?
      redirect_to root_path
    end
    @answers = @question.sorted_answers(current_user)
  end

  def index
    questions = Question.all.sort_by { |q| q.created_at }.reverse
    if Question.question_posted?
      @questions = questions.select! { |q| q != Question.todays_question }
    else
      @questions = questions
    end
  end

  def today
    if Question.todays_answers_posted?
      redirect_to Question.todays_question
    else
      render 'questions/today'
    end
  end

  def release
    Question.release_todays_question!
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
