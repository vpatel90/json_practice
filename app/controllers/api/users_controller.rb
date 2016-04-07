class Api::UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
                     .to_json(include: [:posts, :comments])
  rescue ActiveRecord::RecordNotFound
    err_msg("User")
  end

  def create
    user = User.create(name: params[:name])
    render json: user
  rescue ActiveRecord::RecordInvalid, ArgumentError
    invalid_msg([params[:name]])
  end

  def update
    user = User.find(params[:id])
    user.update(name: params[:name])
    render json: user
  rescue ActiveRecord::RecordInvalid
    invalid_msg([params[:name]])
  rescue ActiveRecord::RecordNotFound
    err_msg("User")
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: "Success", status: 200 }
  rescue ActiveRecord::RecordNotFound
    err_msg("User")
  end
end
