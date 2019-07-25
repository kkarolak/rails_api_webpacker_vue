require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :request do
  let(:user) {FactoryGirl.create(:user,:admin)}
  let(:user1){User.create!(name:"Test", email:"test123@o2.pl", role:"user", password: "password")}
  let!(:jwt_token) { AuthenticateUser.new(user.email, user.password).call }
  let (:article){Article.create!(title:"test",description:"test description",user_id:user.id)}
  let(:params) { {
      title: 'Awesome article',
      description: 'Description',
      user_id: user.id
  }
  }
  context 'Methods' do
    describe 'GET articles#index' do
      it "index action should be success" do
        get '/api/v1/articles'
        expect(response).to have_http_status(:success)
      end
    describe 'GET articles#show' do
      it "show action should be success" do
        get '/api/v1/articles', params: {id: article.id}
        expect(response).to have_http_status(:success)
      end
    end
    describe 'POST articles#create' do
      it 'create new article if authenticated user is admin' do
        expect{(post '/api/v1/articles/', params: {article: params, format: :json}, headers: {'Authorization': "Barer #{jwt_token.result}"})}.to change(Article, :count).by(1)
      end
      it 'do not create new article if authenticated user is not admin' do
        token = AuthenticateUser.new(user1.email, user1.password).call
        expect{(post '/api/v1/articles/', params: {article: params, format: :json}, headers: {'Authorization': "Barer #{token.result}"})}.to change(Article, :count).by(0)
      end

    end
    describe 'PUT # update' do
      it 'update article info' do
        put "/api/v1/articles/#{article.id}", params:{id: article.id, article: params}, headers: {'Authorization': "Barer #{jwt_token.result}"}
        article.reload
        params.keys.each do |key|
          expect(article.attributes[key.to_s]).to eq params[key]
        end
      end
      it 'shouldnt update article info' do
        token = AuthenticateUser.new(user1.email, user1.password).call
        put "/api/v1/articles/#{article.id}", params:{article: params}, headers: {'Authorization': "Barer #{token.result}"}
        article.reload
        expect(article.title.to_s).to_not eq params[:title]
        expect(article.description.to_s).to_not eq params[:description]
      end
    end
    describe 'DELETE # destroy' do
      it 'should delete article' do
        article = Article.create!(id:6 ,title:"First",description:"First Article",user_id: user.id)
        expect { delete "/api/v1/articles/#{article.id}", params: { id: article.id }, headers:{'Authorization': "Barer #{jwt_token.result}"} }.to change(Article, :count).by(-1)
      end
      it 'shouldnt delete article' do
        token = AuthenticateUser.new(user1.email, user1.password).call
        article = Article.create!(id:6 ,title:"First",description:"First Article",user_id: user.id)
        expect { delete "/api/v1/articles/#{article.id}", params: { id: article.id }, headers:{'Authorization': "Barer #{token.result}"} }.to change(Article, :count).by(0)
      end
    end
    end
  end
end
