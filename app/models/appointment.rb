class Appointment < ApplicationRecord
  belongs_to :flat
  belongs_to :user
  validates :status, inclusion: { in: ["Approved", "Rejected", "Pending"] }
  validates :date, presence: true
  validates :time, presence: true
end
