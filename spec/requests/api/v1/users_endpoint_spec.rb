RSpec.describe 'api/v1/teams endpoint', type: :request do
  let!(:application) { FactoryBot.create(:platform_application) }
  let!(:token) do
    Doorkeeper::AccessToken.find_or_create_for(application: application,
                                               resource_owner: application.user,
                                               scopes: application.scopes,
                                               expires_in: 2.hours,
                                               use_refresh_token: true).token
  end
  let(:Authorization) { "Bearer #{token}" }

  path '/me' do
    # GET /me
    get 'Retrieves current user' do
      tags 'User'
      operationId 'getMe'

      response '200', 'team found' do
        schema type: :object, properties: { data: { '$ref' => '#/components/schemas/user' } }

        run_test!
      end
    end
  end
end
