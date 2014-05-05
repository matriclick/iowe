# encoding: UTF-8
class DashboardController < ApplicationController
  before_action :authenticate_user!, :ensure_payment_profile_is_set, except: [:set_time_zone]
  skip_before_filter :verify_authenticity_token
  
  def view
    Time.zone = 'Pacific Time (US & Canada)'
    @debts_and_loans = Transaction.where('(lender_id = ? or debtor_id = ?) and (settled_lender = ? or settled_lender is ?)', current_user.id, current_user.id, false, nil).order 'created_at ASC'
  end

  def ensure_payment_profile_is_set
    if current_user.payment_profile.blank?
      redirect_to new_payment_profile_path and return
    end
  end
  
  def transactions_tracking
  end
  
  def set_time_zone
    @time_zone = params[:time_zone_name]
    if @time_zone
      cookies[:time_zone] = @time_zone if @time_zone
      render :text => "success"
    else
      render :text => "error"
    end
  end
  
end
