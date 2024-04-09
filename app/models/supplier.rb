class Supplier < ApplicationRecord
  has_many :product_models
  validates :corporate_name, :brand_name, :registration_number, :city, :state, :full_address, :email, presence: true
  validates :registration_number, uniqueness: true
end