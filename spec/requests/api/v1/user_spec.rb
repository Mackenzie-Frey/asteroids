require "rails_helper"

describe "GET /user" do
  it "returns a user with a valid API key" do
    user = create(:user, email: "uncle.jesse@example.com", name: "Jesse Katsopolis")
    api_key = create(:api_key)

    get "/api/v1/user?api_key=#{api_key.value}"

    expect(response.status).to eq 200

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to have_key :id
    expect(user).to_not have_key :password_digest

    expect(user[:email]).to eq "uncle.jesse@example.com"
    expect(user[:name]).to  eq "Jesse Katsopolis"
  end

  it "prevents access without a valid API key" do
    api_key = create(:api_key)

    get "/api/v1/user?api_key=NOT_LEGIT"

    expect(response.status).to eq 401
  end

  it "prevents access without an API key" do
    get "/api/v1/user"

    expect(response.status).to eq 401
  end
end

describe 'As a registered user, GET /api/v1/user/favorites?api_key=abc123' do
  it 'returns a JSON response with favorite asteroids' do
    user = User.find_by(email: "uncle.jesse@example.com")
    allow_any_instance_of(ApiBaseController).to receive(:current_user).and_return(user)

    get '/api/v1/user/favorites?api_key=abc123'

    expect(response).to be_successful
    expect(response[0]['id']).to eq(1)
    expect(response[0]['neo_reference_id']).to eq("2153306")
    expect(response[0]['user_id']).to eq(1)
    expect(response[0]['asteroid']['name']).to eq('153306 (2001 JL1)')
    expect(response[0]['asteroid']['is_potentially_hazardous_asteroid']).to eq(false)

  end
end

# `api_key` of `abc123`.
# ```
# As a registered user
# When I send a 'GET' request to '/api/v1/user/favorites?api_key=abc123'
# Then I should receive a JSON response as follows:
# ```
# ```
# [
#   {
#     "id":1,
#     "neo_reference_id": "2153306",
#     "user_id": 1,
#     "asteroid": {
#       "name": "153306 (2001 JL1)",
#       "is_potentially_hazardous_asteroid": false,
#     }
#   }
# ]
