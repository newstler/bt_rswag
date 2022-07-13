module Swagger
  class V1::Schemas::ScaffoldingCompletelyConcreteTangibleThing

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
    end
  end
end
