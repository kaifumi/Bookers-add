class ApplicationController < ActionController::Base
# include ApplicationHelper

	before_action :authenticate_user!, except: [:top, :about]
	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  #デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	# protect_from_forgery with: :exception

  protected
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email,:postcode,
                  :address_city,:prefecture_code,:address_street,:address_building,
                  :latitude,:longitude])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
  end

  # ユーザーのログインを確認する
  def logged_in_user
    unless current_user.present?
      flash[:danger] = "Please log in."
      redirect_to new_user_session_path
    end
  end

  
  # どこでもcurrent_userを使えるようなる
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
