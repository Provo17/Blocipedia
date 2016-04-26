require 'rails_helper'

RSpec.describe Wiki, type: :model do
  
  let(:user) {create("user")}
  let(:wiki) {create("wiki")}
  
  it { is_expected.to belong_to(:user) }
  
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:user) }
  
  describe "attributes" do
      
      it "responds to title" do
          expect(wiki).to respond_to(:title)
      end
      
      it "responds to body" do
          expect(wiki).to respond_to(:body)
      end
  end
end
