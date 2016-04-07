class Api::CommentsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: Comment.where(post_id: params[:post_id])
  end

  def show
    response = Comment.find_by(id: params[:id], post_id: params[:post_id])
    if response.nil?
      raise ActiveRecord::RecordNotFound
    end
    render json: Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end

  def create
    comment = Comment.create(body: params[:body], user_id: params[:commenter_id])
    render json: comment
  rescue ActiveRecord::RecordInvalid
    render json: { message: "Invalid Input", status: 400 }, status: 400
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(body: params[:body], user_id: params[:commenter_id])
    render json: comment
  rescue ActiveRecord::RecordInvalid
    render json: { message: "Invalid Input", status: 400 }, status: 400
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404

  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: { message: "Success", status: 200 }
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end

  def top
    comment = Comment.where(post_id: params[:post_id]).order(votes_count: :DESC).limit(1)
    render json: comment
  end
end
