# encoding: UTF-8
class ApplicationController < ActionController::Base
  before_filter :add_time_zone_variable
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def add_time_zone_variable
    unless cookies[:time_zone].blank?
      @time_zone = cookies[:time_zone] 
    else
      @time_zone = 'Santiago'
    end
  end
end
