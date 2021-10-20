class Cep < ApplicationRecord
  belongs_to :user
  validates :zip_code, :state, :city, :neighborhood, :address, :user_id, presence: true
end
