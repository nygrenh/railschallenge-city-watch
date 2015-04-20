class Emergency < ActiveRecord::Base
  attr_reader :assigned, :full_response

  has_many :responders

  validates :code, uniqueness: true, presence: true
  validates :police_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :medical_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fire_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_create :dispatch_responders

  protected

  def dispatch_responders
    @full_response = ResponderDispatcher.new(self).dispatch
  end
end
