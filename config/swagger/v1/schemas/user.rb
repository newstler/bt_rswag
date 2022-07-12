module Swagger
  class V1::Schemas::User

    def initialize
    end

    def specs
      {
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
      }
    end
  end
end
