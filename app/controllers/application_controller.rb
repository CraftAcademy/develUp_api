class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:company_name, :email, :password, :password_confirmation, :company_url, :role]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

  def error_message(errors)
    error_message = errors.full_messages.to_sentence

    render json: { message: error_message }, status: 422
  end
end
