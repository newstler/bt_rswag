# Dir[__dir__ + '/swagger/v1/schemas/**/*'].each &method(:require)

module Swagger
  class Configuration
    attr_reader :versions, :format

    def initialize(format)
      @format = format
      parent_dir = File.expand_path("..", __dir__)
      @versions = Dir[parent_dir + '/swagger/v[0-99].rb'].map do |version|
        require version
        Object.const_get('Swagger::' + File::basename(version, '.rb').capitalize).new
      end
    end

    def specs
      {}.tap do |hash|
        versions.each do |version|
          version_name = version.class.name.demodulize
          hash["#{version_name.downcase}/swagger.#{format}"] = version.specs
        end
      end
    end
  end
end
