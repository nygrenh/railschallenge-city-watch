class Emergency < ActiveRecord::Base
  attr_reader :assigned

  has_many :responders

  scope :fully_responded, -> { where(full_response: true) }

  validates :code, uniqueness: true, presence: true
  validates :police_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :medical_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fire_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_create :dispatch_responders
  before_update :free_responders

  def resolved?
    resolved_at != nil
  end

  protected

  def dispatch_responders
    ResponderDispatcher.new(self).dispatch
    save!
  end

  def free_responders
    self.responders = [] if resolved?
  end
end
