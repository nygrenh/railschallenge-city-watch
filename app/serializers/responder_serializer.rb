class ResponderSerializer < ActiveModel::Serializer
  attributes :emergency_code, :type, :name, :capacity, :on_duty

  def type
    object.type.titlecase
  end
end
