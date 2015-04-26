class Responder < ActiveRecord::Base
  # We want to use field 'type' without single-table inheritance
  self.inheritance_column = nil

  # We want to see this on API reponses but it's useless for the
  # application so we don't need to save it in the database
  attr_accessor :emergency_code

  belongs_to :emergency

  enum type: %w(fire police medical)

  scope :available, -> { where(emergency_id: nil) }
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

  def free_from_assignment
    self.emergency = nil
    save!
  end

  protected

  def attach_emergency
    return unless emergency_code
    self.emergency = Emergency.find_by(code: emergency_code)
  end
end
