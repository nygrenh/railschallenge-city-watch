class Responder < ActiveRecord::Base
  self.inheritance_column = nil

  validates :capacity, presence: true, inclusion: { in: 1..5 }
  validates :name, uniqueness: true, presence: true
  validates :type, presence: true
end
