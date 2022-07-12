module Swagger
  class V1::Schemas
    attr_reader :schemas

    def initialize
      @schemas = Dir[__dir__ + '/schemas/*.rb'].map do |schema|
        require schema
        Object.const_get('Swagger::V1::Schemas::' + File::basename(schema, '.rb').camelize).new
      end
    end

    def specs
      {}.tap do |hash|
        schemas.each do |schema|
          schema_name = schema.class.name.demodulize
          hash[schema_name.underscore] = schema.specs
        end
      end
    end
  end
end