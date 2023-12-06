require 'rails_helper'

RSpec.describe "Wildlives", type: :request do
  describe "POST /wildlives" do
    it "returns status code 422 and validation errors for missing attributes" do
      post "/wildlives", params: { wildlife: { common_name: "", scientific_binomial: "" } }
      expect(response).to have_http_status(422)
      expect(response.body).to include("Common name can't be blank")
      expect(response.body).to include("Scientific binomial can't be blank")
    end

    it "returns status code 422 and validation errors for non-unique attributes" do
      existing_wildlife = create(:wildlife, common_name: "Tiger", scientific_binomial: "Panthera tigris")
      post "/wildlives", params: { wildlife: { common_name: "Tiger", scientific_binomial: "Panthera tigris" } }
      expect(response).to have_http_status(422)
      expect(response.body).to include("Common name has already been taken")
      expect(response.body).to include("Scientific binomial has already been taken")
    end
  end
end
