module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_article, only:[:index,:create,:update]
      before_action :set_comment, only:[:update,:destroy]
      skip_before_action :authenticate_request, only:[:index]

      # GET /comments
      def index
        @comments = @article.comments.all

        render json: @comments
      end
      # POST /comments
      def create
        comment = @article.comments.new(comment_params)
        comment.status = "unpublished"
        if comment.save
          render json: comment, status: :created
        else
          render json: {
            error: comment.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /comments/1
      #Tylko twórca komentarza może go edytować
      def update
        if @current_user.role == "admin" && @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /comments/1
      # Tylko twórca komentarza może go usunąć
      def destroy
        if @current_user.role == "admin"
          @comment.destroy
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_article
          @article = Article.find(params[:article_id])
          render json: {
          error: 'not found'
        }, status: 404 if @article.nil?
        end
        def set_comment
          @comment = Comment.find(params[:id])
          render json: {
            error: 'not found'
          }, status: 404 if @comment.nil?
        end

        def comment_params
          params.permit(:content,:user_id,:status)
        end
    end
  end
end
