class Flat < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  validates :title, uniqueness: true
  validates :price, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :number_of_rooms, presence: true
end
