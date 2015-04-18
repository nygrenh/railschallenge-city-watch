module ActiveModel
  class ErrorsSerializer < Serializer
    self.root = false

    attributes :message

    def message
      object.to_hash
    end
  end
end
