class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  skip_before_action :authorized_admin, only: [:index]
  
  def index
  end
end
