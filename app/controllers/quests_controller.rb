class QuestsController < ApplicationController
before_action :set_quest!, only: %i[edit update destroy show]
  
  def index
    @quests = Quest.all
  end

  def new
    @quest = Quest.new
  end

  def create
    @quest = Quest.new quest_params
    if @quest.save
      flash[:success] = "Question created"
      redirect_to quests_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @quest.update quest_params
      flash[:success] = "Answer updated!"
      redirect_to quests_path
    else
      render :edit
    end
  end

  def destroy
    @quest.destroy #if ????
    flash[:success] = "Question deleted!"
    redirect_to quests_path
  end

  def show
    @answer = @quest.answers.build
    @answers = @quest.answers.order created_at: :desc
  end

  private
  def set_quest!
    @quest = Quest.find params[:id]
  end

  def quest_params
    params.require(:quest).permit(:title, :body)
  end
end
