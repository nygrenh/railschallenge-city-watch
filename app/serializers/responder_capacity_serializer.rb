class ResponderCapacitySerializer < ActiveModel::Serializer
  self.root = 'capacity'

  def attributes
    { Fire: @object.fire, Police: @object.police, Medical: @object.medical }
  end
end
