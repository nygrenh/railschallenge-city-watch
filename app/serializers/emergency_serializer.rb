class EmergencySerializer < ActiveModel::Serializer
  attributes :code, :fire_severity, :police_severity, :medical_severity
end
