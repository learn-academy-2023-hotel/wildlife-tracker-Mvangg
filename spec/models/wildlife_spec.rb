require 'rails_helper'

require 'rails_helper'

RSpec.describe Wildlife, type: :model do
  it "requires a common name and scientific binomial" do
    wildlife = Wildlife.new
    expect(wildlife).to_not be_valid
    expect(wildlife.errors[:common_name]).to include("can't be blank")
    expect(wildlife.errors[:scientific_binomial]).to include("can't be blank")
  end

  it "validates uniqueness of common name and scientific binomial" do
    existing_wildlife = create(:wildlife, common_name: "Tiger", scientific_binomial: "Panthera tigris")
    wildlife = build(:wildlife, common_name: "Tiger", scientific_binomial: "Panthera tigris")
    
    expect(wildlife).to_not be_valid
    expect(wildlife.errors[:common_name]).to include("has already been taken")
    expect(wildlife.errors[:scientific_binomial]).to include("has already been taken")
  end
end
