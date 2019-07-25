require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) {FactoryGirl.create(:user,:admin)}
  let(:user1){User.create!(name:"Test", email:"test123@o2.pl", role:"user", password: "password")}
  let!(:jwt_token) { AuthenticateUser.new(user.email, user.password).call }
  let(:params) { {
      name: "test",
      email: "test@netkodo.com",
  }
  }
  context 'Methods' do
    describe 'GET users#index' do
      it "index action should be success" do
        get "/api/v1/users"
        expect(response).to have_http_status(:success)
      end
    end
    describe 'GET users#show' do
      it "show action should be success" do
        get '/api/v1/users/', params: {id: user.id}
        expect(response).to have_http_status(:success)
      end
    end
    describe 'POST users#register' do
      it 'register new user' do
        expect{(post '/api/v1/auth/register', params: {name:"Test", email:"test@o2.pl", password:"password"})}.to change(User, :count).by(1)
      end
    end
    describe 'PUT # update' do
      it 'update user info' do
        put "/api/v1/users/#{user.id}", params:{name: "test", email: "test@netkodo.com"}, headers: {'Authorization': "Barer #{jwt_token.result}"}
        user.reload
        #puts response.body
        params.keys.each do |key|
          expect(user.attributes[key.to_s]).to eq params[key]
        end
      end
      it 'shouldnt update user info' do
        token = AuthenticateUser.new(user1.email, user1.password).call
        put "/api/v1/users/#{user1.id}", params:{name: "test", email: "test@netkodo.com"}, headers: {'Authorization': "Barer #{token.result}"}
        user.reload
        expect(user.name.to_s).to_not eq params[:name]
        expect(user.email.to_s).to_not eq params[:email]
      end
    end
    describe 'DELETE # destroy' do
      it 'should delete user' do
        user2 = User.create!(name:"Test1", email:"tttt1@o2.pl", role:"user", password: "password")
        expect { delete "/api/v1/users/#{user2.id}", params: { id: user2.id }, headers:{'Authorization': "Barer #{jwt_token.result}"} }.to change(User, :count).by(-1)
      end
      it 'shouldnt delete article' do
        token = AuthenticateUser.new(user1.email, user1.password).call
        expect { delete "/api/v1/users/#{user.id}", params: { id: user.id }, headers:{'Authorization': "Barer #{token.result}"} }.to change(Article, :count).by(0)
      end
    end
    describe '#login' do
      it 'should receive token' do
      post '/api/v1/auth/login', params: {password:user.password, email:user.email}
      expect(response.body).to include jwt_token.result
    end
    end
end
end
