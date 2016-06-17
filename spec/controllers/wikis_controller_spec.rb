require 'rails_helper'
include Devise::TestHelpers

RSpec.describe WikisController, type: :controller do
  

  
  let(:my_user) { create(:user) }
  let(:my_wiki) { Wiki.create!(title: "New wiki title", body: "New wiki body", user: my_user ) } 
  let(:my_private_wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", public: false) }

  before do
    sign_in my_user
  end

  describe "GET #index" do
    
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
  
    it "assigns my_wiki to @wiki" do
      my_wiki
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end
  end
  
  
  
  describe "GET #new" do
    
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
    
    it "instanates @wiki" do
      get :new
      expect(assigns(:wiki)).to_not be_nil
    end
  end
    
    
  describe "WIKI create" do
    
      
    it "increases the number of wiki by 1" do
      expect{create( :wiki)}.to change(Wiki,:count).by(1) #changed notation
    end
    
    it "assigns the new wiki to @wiki" do
      expect(assigns(:wiki)).to eq Wiki.last
    end
    
    it "redirects to the new wiki" do
      post :create, wiki: {title: "New wiki title", body: "New wiki body"}
      expect(response).to redirect_to Wiki.last
    end
  end  
  
  

  describe "GET #show" do
    
    it "returns http success" do
      get :show, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
      get :show, {id: my_wiki.id}
      expect(response).to render_template :show
    end
    
    it "assigns my_wiki to @wiki" do 
      get :show, {id: my_wiki.id}
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end



  describe "GET #edit" do
    
    it "returns http success" do
      get :edit, {id: my_wiki.id} 
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #edit view" do
      get :edit, {id: my_wiki.id}
      expect(response).to render_template :edit
    end
    
    it "assigns post to be updated to @wiki" do
      get :edit, {id: my_wiki.id}
      
      wiki_insatnce = assigns(:wiki)
      
      expect(wiki_insatnce.id).to eq my_wiki.id
      expect(wiki_insatnce.title).to eq my_wiki.title
      expect(wiki_insatnce.body).to eq my_wiki.body
    end
  end
  
  
  
   describe "PUT update" do
     
     it "updates wiki with expected attributes" do
       new_title = "New wiki title"
       new_body = "New wiki body"
 
       put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}

       updated_wiki = assigns(:wiki)
       expect(updated_wiki.id).to eq my_wiki.id
       expect(updated_wiki.title).to eq new_title
       expect(updated_wiki.body).to eq new_body
     end
 
     it "redirects to the updated wiki" do
       new_title = "New wiki title"
       new_body = "New wiki body"

       put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
       expect(response).to redirect_to my_wiki
     end
   end  
   
   
   
   describe "DELETE destroy" do
     
     it "deletes the wiki" do
       delete :destroy, {id: my_wiki.id}
       count = Wiki.where({id: my_wiki.id}).size
       expect(count).to eq(0)
     end
 
     it "redirects to wikis index" do
       delete :destroy, {id: my_wiki.id}
       expect(response).to redirect_to wikis_path
     end
   end
end
