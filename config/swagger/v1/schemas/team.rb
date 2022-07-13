module Swagger
  class V1::Schemas::Team

    def initialize
    end

    def specs
      scaffolding_things_disabled? ? base : base[:properties][:relationships][:properties].merge!(scaffolding_things)
    end

    private

    def base
      {
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
            }
          }
        }
      }
    end

    def scaffolding_things
      {
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
      }
    end
  end
end
