class QuestionsController < ApplicationController

  def today
    @question = Question.where('created_at BETWEEN ? AND ?',
                DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
  end

  def show
  end

  def index
  end
end
