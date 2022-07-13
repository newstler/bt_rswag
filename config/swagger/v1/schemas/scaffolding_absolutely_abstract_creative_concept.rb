module Swagger
  class V1::Schemas::ScaffoldingAbsolutelyAbstractCreativeConcept

    def initialize
    end

    def specs
      scaffolding_things_disabled? ? nil : base
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
      }
    end
  end
end
