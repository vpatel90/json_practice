class Api::PostsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: Post.where(user_id: params[:user_id])
  end

  def show
    response = Post.find_by(id: params[:id], user_id: params[:user_id])
    if response.nil?
      raise ActiveRecord::RecordNotFound
    end
    render json: response.to_json(include: :comments)
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end

  def create
    post = Post.create(title: params[:title], body: params[:body], user_id: params[:user_id])
    render json: post
  rescue ActiveRecord::RecordInvalid
    render json: { message: "Invalid Input", status: 400 }, status: 400
  end

  def update
    post = Post.find(params[:id])
    post.update(title: params[:title], body: params[:body], user_id: params[:user_id])
    render json: post
  rescue ActiveRecord::RecordInvalid
    render json: { message: "Invalid Input", status: 400 }, status: 400
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404

  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    render json: { message: "Success", status: 200 }
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end
end
