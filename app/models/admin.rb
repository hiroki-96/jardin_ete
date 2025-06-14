class Admin < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, authentication_keys: [:login_id]

  # email不要、login_id必須
  validates :login_id, presence: true, uniqueness: true
  def email_required?; false; end
  def email_changed?; false; end
  def will_save_change_to_email?; false; end
end 