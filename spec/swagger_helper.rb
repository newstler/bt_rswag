# frozen_string_literal: true

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  # TODO: Generate servers[:url] automatically
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: "#{I18n.t('application.name')} API",
        version: 'V1'
      },
      paths: {},
      schemes: %w[https],
      servers: [
        {
          url: 'https://btapi.eu.ngrok.io/api/v1'
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
        schemas: {
          # team: { '$ref': YAML.parse(File.read(Rails.root.join 'spec', 'support', 'api', 'v1', 'schemas', 'team.yaml')) }
          # team: JSON.parse(File.read(File.join(__dir__, 'requests', 'api', 'v1', 'team.yaml')))
          team: {
            type: :object,
            properties: {
              id: { type: :string },
              type: { type: :string },
              attributes: {
                type: :object,
                required: %w[name],
                properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  time_zone: { type: :string, nullable: true },
                  locale: { type: :string, nullable: true },
                  created_at: { type: :string, format: :"date-time" },
                  updated_at: { type: :string, format: :"date-time" }
                }
              },
              relationships: {
                type: :object,
                properties: {
                  # unless scaffolding_things_disabled?
                    scaffolding_absolutely_abstract_creative_concepts: {
                      type: :object,
                      properties: {
                        data: {
                          type: :array,
                          items: {
                            type: :object,
                            properties: {
                              id: { type: :string },
                              type: { type: :string }
                            }
                          }
                        }
                      }
                    }
                  # end
                }
              }
            }
          },
          user: {
            type: :object,
            properties: {
              id: { type: :string },
              type: { type: :string },
              attributes: {
                type: :object,
                required: %w[email],
                properties: {
                  id: { type: :integer },
                  email: { type: :string },
                  first_name: { type: :string, nullable: true },
                  last_name: { type: :string, nullable: true },
                  time_zone: { type: :string, nullable: true },
                  profile_photo_id: { type: :integer, nullable: true },
                  former_user: { type: :boolean },
                  locale: { type: :string, nullable: true },
                  created_at: { type: :string, format: :"date-time" },
                  updated_at: { type: :string, format: :"date-time" }
                }
              },
              relationships: {
                type: :object,
                properties: {
                  teams: {
                    type: :object,
                    properties: {
                      data: {
                        type: :array,
                        items: {
                          type: :object,
                          properties: {
                            id: { type: :string },
                            type: { type: :string }
                          }
                        }
                      }
                    }
                  },
                  memberships: {
                    type: :object,
                    properties: {
                      data: {
                        type: :array,
                        items: {
                          type: :object,
                          properties: {
                            id: { type: :string },
                            type: { type: :string }
                          }
                        }
                      }
                    }
                  },
                  # unless scaffolding_things_disabled?
                  scaffolding_absolutely_abstract_creative_concepts: {
                    type: :object,
                    properties: {
                      data: {
                        type: :array,
                        items: {
                          type: :object,
                          properties: {
                            id: { type: :string },
                            type: { type: :string }
                          }
                        }
                      }
                    }
                  }
                  # end
                }
              }
            }
          },
          scaffolding_absolutely_abstract_creative_concept: {
            type: :object,
            properties: {
              id: { type: :string },
              type: { type: :string },
              attributes: {
                type: :object,
                required: %w[team_id name],
                properties: {
                  id: { type: :integer },
                  team_id: { type: :integer },
                  name: { type: :string },
                  description: { type: :string },
                  created_at: { type: :string, format: :"date-time" },
                  updated_at: { type: :string, format: :"date-time" }
                }
              },
              relationships: {
                type: :object,
                properties: {
                  team: {
                    type: :object,
                    properties: {
                      data: {
                        type: :object,
                        properties: {
                          id: { type: :string },
                          type: { type: :string }
                        }
                      }
                    }
                  },
                  completely_concrete_tangible_things: {
                    type: :object,
                    properties: {
                      data: {
                        type: :array,
                        items: {
                          type: :object,
                          properties: {
                            id: { type: :string },
                            type: { type: :string }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          },
          scaffolding_completely_concrete_tangible_thing: {
            type: :object,
            properties: {
              id: { type: :string },
              type: { type: :string },
              attributes: {
                type: :object,
                required: %w[name],
                properties: {
                  id: { type: :integer },
                  absolutely_abstract_creative_concept_id: { type: :integer },
                  text_field_value: { type: :string },
                  button_value: { type: :string },
                  multiple_button_values: { type: :jsonb },
                  color_picker_value: { type: :string },
                  cloudinary_image_value: { type: :string },
                  date_field_value: { type: :string, format: :date },
                  date_and_time_field_value: { type: :string, format: :"date-time" },
                  email_field_value: { type: :string },
                  password_field_value: { type: :string },
                  phone_field_value: { type: :string },
                  option_value: { type: :string },
                  super_select_value: { type: :string },
                  created_at: { type: :string, format: :"date-time" },
                  updated_at: { type: :string, format: :"date-time" }
                }
              },
              relationships: {
                type: :object,
                properties: {
                  absolutely_abstract_creative_concept: {
                    type: :object,
                    properties: {
                      data: {
                        type: :object,
                        properties: {
                          id: { type: :string },
                          type: { type: :string }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
