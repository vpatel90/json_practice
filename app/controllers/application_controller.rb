class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def err_msg(item, item_two = nil)
    msg = "#{item} with the given ID does not exist for this #{item_two}"
    msg = "#{item} with the given ID does not exist" if item == "User"
    render json: { message: "#{item} with the given ID does not exist", status: 404 }, status: 404
  end

  def invalid_msg(input = nil)

    if input.empty?
      response = "You didn't send me the right params"
    else
      response = "You might've sent me an empty string"
    end
    render json: { message: response, status: 400 }, status: 400
  end
end
