# frozen_string_literal: true

class QuestDecorator < ApplicationDecorator
  delegate_all

  def formatted_created_at
    created_at.strftime('%Y-%m-%d')
  end
end
