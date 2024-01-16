class User < ApplicationRecord
  has_secure_password
  before_create :generate_api_key

  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  private
  def generate_api_key
    api_key = SecureRandom.hex(13)
    self.api_key = api_key[0..8] + "_" + api_key[9..12] + "_" + api_key[13..25]
  end
end