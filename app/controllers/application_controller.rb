class ApplicationController < ActionController::Base
  before _action :basic_auth

  private 
  def basic_auth
   authenticate_or_request_with_http_basic do |username, password|
    username == 'yoheikajiyama' && password == '19920913'
   end
  end

end
