class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_member,{only:[:home, :about]}

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_members_path
    when Member
      member_path(resource)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:name, :gender])
  end
end
