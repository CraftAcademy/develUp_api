RSpec.describe "GET /api/assignments", type: :request do
  let(:client) { create(:client) }
  let(:credentials) { client.create_new_auth_token }
  let(:assignment) { create(:assignment) }
  let(:headers) { { HTTP_ACCEPT: "application/json" }.merge!(credentials) }
  describe "visitor can see specific assignments" do
    before do
      get "/api/assignments/#{assignment.id}",
          headers: headers
    end
    it "responds with ok status" do
      expect(response).to have_http_status :ok
    end
    it "returns a specific assignment title" do
      expect(response_json["assignment"]["title"]).to eq "MyString"
    end
    it "returns a specific assignment description" do
      expect(response_json["assignment"]["description"]).to eq "MyText"
    end
    it "returns a specific assignment skills" do
      expect(response_json["assignment"]["skills"]).to eq ["Javascript", "Ruby"]
    end
    it "returns a specific assignment budget" do
      expect(response_json["assignment"]["budget"]).to eq 500
    end
    it "returns a specific assignment poins" do
      expect(response_json["assignment"]["points"]).to eq 320
    end
  end
  describe "request with wrond id fails" do
    before do
      get "/api/assignments/wrongId",
          headers: headers
    end
    it "responds with not found status" do
      expect(response).to have_http_status :not_found
    end
    it "is expected to return with error message" do
      expect(response_json["error_message"]).to eq "Sorry, that assignment does not exist"
    end
  end
  describe "visitor can't see specific assignment" do
    before do
      get "/api/assignments/#{assignment.id}"
    end
    it "is expected to return unauthozired response status" do
      expect(response).to have_http_status :unauthorized
    end
    it "is expected to return error message" do
      expect(response_json["errors"][0]).to eq "You need to sign in or sign up before continuing."
    end
  end
end
