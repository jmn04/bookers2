class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # Sign up・Log in後の遷移先
  def after_sign_in_path_for(resource)
    user_path(current_user)  # ユーザーの詳細画面
  end

  # サインアウト後の遷移先
  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
    root_path
  end


  protected

  # sign_up時のname, emailのデータ操作許可設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
