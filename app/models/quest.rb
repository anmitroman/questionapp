class Quest < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true, length: { minimum: 5 }

  def formatted_created_at
    self.created_at.strftime('%Y-%m-%d')
  end
end
