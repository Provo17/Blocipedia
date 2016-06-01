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
  
  
     describe "scopes" do
     
     before do
       @public_wiki = Wiki.create!(title: "new wiki title", body: "new wiki body", user: user)
      # @private_Wiki = Wiki.create!(title: "new wiki title", body: "new wiki body", user: user, private: true)
     end
 
     describe "visible_to(user)" do
       
       it "returns all topics if the user is present" do
         user = User.new
         expect(Wiki.visible_to(user)).to eq(Wiki.all)
       end
 
       it "returns only public topics if user is nil" do
         expect(Wiki.visible_to(nil)).to eq([@public_wiki])
       end
     end
   end
end
