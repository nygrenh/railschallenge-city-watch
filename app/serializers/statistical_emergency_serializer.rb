class StatisticalEmergencySerializer < ActiveModel::Serializer
  self.root = false

  has_many :emergencies
  has_many :full_responses
end
