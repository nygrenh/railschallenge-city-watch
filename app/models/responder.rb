class Responder < ActiveRecord::Base
  # We want to use field 'type' without single-table inheritance
  self.inheritance_column = nil

  belongs_to :emergency

  enum type: %w(fire police medical)

  scope :available, -> { where(emergency_code: nil) }
  scope :on_duty, -> { where(on_duty: true) }
  scope :ready, -> { available.on_duty }

  validates :capacity, presence: true, inclusion: { in: 1..5 }
  validates :name, uniqueness: true, presence: true
  validates :type, presence: true

  before_save :attach_emergency

  # Make assignments to type to work with all strings
  def type=(value)
    super(value.downcase)
  end

  protected

  def attach_emergency
    return unless emergency_code
    self.emergency = Emergency.find_by(code: emergency_code)
  end
end
