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

  path '/teams' do
    # GET /teams
    get 'Retrieves a list of teams' do
      tags 'Team'
      operationId 'listTeams'
      parameter name: :page, in: :query, type: :integer, required: false

      response '200', 'teams found' do
        schema type: :object, properties: { data: { type: :array, items: { '$ref' => '#/components/schemas/team' } } }

        let(:teams) { FactoryBot.create_list(:team, 10) }
        run_test!
      end
    end

    # POST /teams
    post 'Creates a team' do
      tags 'Team'
      operationId 'createTeam'
      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          locale: { type: :string }
        },
        required: %w[name]
      }

      response '201', 'team created' do
        schema type: :object, properties: { data: { '$ref' => '#/components/schemas/team' } }

        let(:team) { { name: 'Bullet Train' } }
        run_test!
      end

      response '406', 'not acceptable' do
        let(:team) { { name: '' } }
        run_test!
      end
    end
  end

  path '/teams/{id}' do
    # GET /teams/{id}
    get 'Retrieves a team' do
      tags 'Team'
      operationId 'getTeam'
      parameter name: :id, in: :path, type: :string

      response '200', 'team found' do
        schema type: :object, properties: { data: { '$ref' => '#/components/schemas/team' } }

        let(:id) { application.team.id }
        run_test!
      end

      response '404', 'team not found' do
        let(:id) { 1000 }
        run_test!
      end
    end

    # PUT /teams/{id}
    put 'Updates a team' do
      tags 'Team'
      operationId 'updateTeam'
      parameter name: :id, in: :path, type: :string
      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          locale: { type: :string }
        },
        required: %w[name]
      }

      response '200', 'team updated' do
        schema type: :object, properties: { data: { '$ref' => '#/components/schemas/team' } }
        let(:id) { application.team.id }
        let(:team) { { name: 'Bullet Train Updated' } }
        run_test!
      end

      response '404', 'team not found' do
        let(:id) { 1000 }
        let(:team) { { name: 'Bullet Train Updated' } }
        run_test!
      end

      response '406', 'not acceptable' do
        let(:id) { application.team.id }
        let(:team) { { name: '' } }
        run_test!
      end
    end
  end
end
