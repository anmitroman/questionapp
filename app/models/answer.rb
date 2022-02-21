# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :quest

  validates :body, presence: true, length: { minimum: 5 }
end
