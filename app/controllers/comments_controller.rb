class CommentsController < ApplicationController
  before_action :set_article

  # GET /comments
  def index
    @comments = @article.comments.all

    render json: @comments
  end
  # POST /comments
  def create
    comment = @article.comments.new(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: {
        error: comment.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:article_id])
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:article_id])
      render json: {
      error: 'not found'
    }, status: 404 if @article.nil?
    end

    def comment_params
      params.permit(:content)
    end
end
