class QuestDecorator < ApplicationDecorator
  delegate_all

  def formatted_created_at
    self.created_at.strftime('%Y-%m-%d')
  end
end
