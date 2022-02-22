# frozen_string_literal: true

class AnswersController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_quest!
  before_action :set_answer!, except: :create

  def create
    @answer = @quest.answers.build answer_params
    if @answer.save
      flash[:success] = 'Answer created'
      redirect_to quest_path(@quest)
    else
      @quest = @quest.decorate
      @answers = @quest.answers.order(created_at: :desc).page(params[:page])
      @answers = @answers.decorate
      render 'quests/show'
    end
  end

  def destroy
    @answer.destroy
    # binding.break
    flash[:success] = 'Answer deleted!'
    redirect_to quest_path(@quest), status: :see_other
  end

  def edit; end

  def update
    if @answer.update answer_params
      flash[:success] = 'Answer updated!'
      redirect_to quest_path(@quest, anchor: dom_id(@answer))
      # redirect_to quest_path(@quest)
      # сначала отправляется, а потом в урле чистится якорь, разобраться
    else
      render :edit
    end
  end

  private

  def set_quest!
    @quest = Quest.find params[:quest_id]
  end

  def set_answer!
    @answer = @quest.answers.find params[:id]
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
