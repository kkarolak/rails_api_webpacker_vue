require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  let(:user) {FactoryGirl.create(:user,:admin)}
  let(:user1){User.create!(name:"Test", email:"test123@o2.pl", role:"user", password: "password")}
  let!(:jwt_token) { AuthenticateUser.new(user.email, user.password).call }
  let (:article){Article.create!(title:"test",description:"test description",user_id:user.id)}
  let(:params) { {
      content: 'Awesome article',
      user_id: user.id,
      article_id: article.id,
      status: "published"
  }
  }
  context 'Methods' do
    describe 'GET articles#index' do
      it "index action should be success" do
        get "/articles/#{article.id}/comments"
        expect(response).to have_http_status(:success)
      end
    describe 'POST comments#create' do
      it 'create new comment if authenticated user is admin' do
        expect{(post "/articles/#{article.id}/comments", params: {article_id:article.id,content:'lalal', user_id: user.id}, headers: {'Authorization': "Barer #{jwt_token.result}"})}.to change(Comment, :count).by(1)
        #puts response.body
      end
      it 'create new comment if authenticated user is not admin' do
        token = AuthenticateUser.new(user1.email, user1.password).call
        expect{(post "/articles/#{article.id}/comments", params: {article_id:article.id,content:'lalal', user_id: user.id}, headers: {'Authorization': "Barer #{token.result}"})}.to change(Comment, :count).by(1)
        #puts response.body
      end
    end
    describe 'PUT # update' do
      it 'allows update comment info if authenticated user is admin' do
        comment = Comment.create!(content:"Awesome article", user_id:user.id,article_id:article.id,status:"unpublished")
        put "/articles/#{article.id}/comments/#{comment.id}", params:{id: comment.id,article_id: article.id, status:"published"}, headers: {'Authorization': "Barer #{jwt_token.result}"}
        comment.reload
        params.keys.each do |key|
        expect(comment.attributes[key.to_s]).to eq params[key]
        end
      end
      it 'prevents update comment info if authenticated user is not admin' do
        comment = Comment.create!(content:"Awesome article", user_id:user.id,article_id:article.id,status:"unpublished")
        token = AuthenticateUser.new(user1.email, user1.password).call
        put "/articles/#{article.id}/comments/#{comment.id}", params:{id: comment.id,article_id: article.id, status:"published"}, headers: {'Authorization': "Barer #{token.result}"}
        comment.reload
        expect(comment.attributes[:status]).to_not eq params[:status]
      end
    end
    describe 'DELETE # destroy' do
      it 'should delete comment' do
        comment = Comment.create!(content:"Awesome article", user_id:user.id,article_id:article.id,status:"unpublished")
        expect { delete "/articles/#{article.id}/comments/#{comment.id}", params: { id: comment.id }, headers:{'Authorization': "Barer #{jwt_token.result}"} }.to change(Comment, :count).by(-1)
      end
      it 'shouldnt delete article' do
        token = AuthenticateUser.new(user1.email, user1.password).call
        comment = Comment.create!(content:"Awesome article", user_id:user.id,article_id:article.id,status:"unpublished")
        expect { delete "/articles/#{article.id}/comments/#{comment.id}", params: { id: comment.id }, headers:{'Authorization': "Barer #{token.result}"} }.to change(Article, :count).by(0)
      end
    end
    end
  end
end
