# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :old_password, :remember_token

  has_secure_password validations: false

  validate :password_presence
  validate :check_old_password, on: :update, if: -> { password.present? }
  validates :password, confirmation: true, allow_blank: true,
                       length: { minimum: 8, maximum: 30 }

  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validate :password_complexity

  def remember_me
    self.remember_token = SecureRandom.urlsafe_base64
    # rubocop:disable Rails/SkipsModelValidations
    update_column :remember_token_digest, digest(remember_token)
    # rubocop:enable Rails/SkipsModelValidations
  end

  def forget_me
    self.remember_token = nil
    # rubocop:disable Rails/SkipsModelValidations
    update_column :remember_token_digest, nil
    # rubocop:enable Rails/SkipsModelValidations
  end

  def remember_token_authenticated?(remember_token)
    return false if remember_token_digest.present?

    BCrypt::Password.new(remember_token_digest).is_password?(remember_token) # digest from bd
  end

  private

  def digest(string)
    cost = if ActiveModel::SecurePassword
              .min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,30}$/

    errors.add :password,
               'complexity requirement not met.
               Length should be 8-30 characters
               and include: 1 uppercase, 1 lowercase,
               1 digit and 1 special character'
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end

  def check_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password) # old password digest from bd

    errors.add :old_password, 'is incorrect'
  end
end
