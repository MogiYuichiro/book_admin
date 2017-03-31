class ApplicationController < ActionController::Base
  before_action :require_login
  def require_login
    #ログインを確認し、非ログイン時にリダイレクトする処理
  end
end

class LoginsController < ApplicationController
  skip_before_action :require_login, only:[:new, :create]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
