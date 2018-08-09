class ApplicationController < ActionController::Base
  #CSRF
  protect_from_forgery with: :exception
  # To set up a controller with user authentication
  before_action :authenticate_user!
  # I18n switch language by user
  before_action :set_locale

  private
  def set_locale
    if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
      session[:locale] = params[:locale]
    end
  end
end
