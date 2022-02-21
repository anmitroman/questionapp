# frozen_string_literal: true

class Quest < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true, length: { minimum: 5 }
end
