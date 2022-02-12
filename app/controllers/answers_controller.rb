class AnswersController < ApplicationController
  before_action :set_quest!

  def create
    @answer = @quest.answers.build answer_params

    if @answer.save
      flash[:success] = "Answer created"
      redirect_to quest_path(@quest)
    else
      @answers = @quest.answers.order created_at: :desc
      render 'quests/show'
    end
  end

  def destroy
    @answer = @quest.answers.find params[:id]
    @answer.destroy
    # binding.break
    flash[:success] = "Answer deleted"
    redirect_to quest_path(@quest), status: 303
  end

  private

  def set_quest!
    @quest = Quest.find params[:quest_id]
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
