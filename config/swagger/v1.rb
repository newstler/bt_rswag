module Swagger
  class V1
    attr_reader :name, :schemas

    def initialize
      @name = self.class.name.demodulize
      require_relative "#{name.downcase}/schemas.rb"
      @schemas = Object.const_get("Swagger::#{name}::Schemas").new
    end

    def specs
      {
        openapi: '3.0.1',
        info: {
          title: "#{I18n.t('application.name')} API",
          version: name
        },
        paths: {},
        schemes: [ENV['BASE_URL'].split('://').first],
        servers: [
          {
            url: "#{ENV['BASE_URL']}/api/#{name.downcase}"
          }
        ],
        security: [Bearer: []],
        consumes: ['application/vnd.api+json'],
        produces: ['application/vnd.api+json'],
        components: {
          securitySchemes: {
            Bearer: {
              description: 'Application token necessary to use API calls',
              name: 'Authorization',
              in: :header,
              type: 'http',
              scheme: 'bearer',
              bearerFormat: 'Auth token'
            }
          },
          schemas: schemas.specs
        }
      }
    end
  end
end