class Api::UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
                     .to_json(include: [:posts, :comments])
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end

  def create
    user = User.create(name: params[:name])
    render json: user
  rescue ActiveRecord::RecordInvalid
    render json: { message: "Invalid Input", status: 400 }, status: 400
  end

  def update
    user = User.find(params[:id])
    user.update(name: params[:name])
    render json: user
  rescue ActiveRecord::RecordInvalid
    render json: { message: "Invalid Input", status: 400 }, status: 400
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404

  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: "Success", status: 200 }
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end
end
