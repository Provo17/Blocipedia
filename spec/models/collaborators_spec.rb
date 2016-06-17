require 'rails_helper'

RSpec.describe Collaboration, type: :model do
  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", public: true) }
  let(:user) { User.create!(email: "user@example.com", password: "password", role: "standard")}

  it { is_expected.to belong_to(:user)}
  it { is_expected.to belong_to(:wiki)}

end