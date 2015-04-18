class Responder < ActiveRecord::Base
  # We want to use field 'type' without single-table inheritance
  self.inheritance_column = nil

  enum type: %w(fire police medical)

  validates :capacity, presence: true, inclusion: { in: 1..5 }
  validates :name, uniqueness: true, presence: true
  validates :type, presence: true

  # Make assignments to type to work with all strings
  def type=(value)
    super(value.downcase)
  end
end
