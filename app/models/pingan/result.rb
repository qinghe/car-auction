module Pingan
  class Result
    #include ActiveModel::Model
    include ActiveModel::Serializers::Xml
    attr_accessor :succeed, :message


    def attributes
      instance_values
    end

  end
end
