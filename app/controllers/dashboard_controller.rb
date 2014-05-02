# encoding: UTF-8
class DashboardController < ApplicationController
  before_action :authenticate_user!, :ensure_payment_profile_is_set

  def view
    @debts_and_loans = Transaction.where('(lender_id = ? or debtor_id = ?) and (settled_lender = ? or settled_lender is ?)', current_user.id, current_user.id, false, nil).order 'created_at ASC'
  end

  def ensure_payment_profile_is_set
    if current_user.payment_profile.blank?
      redirect_to new_payment_profile_path and return
    end
  end
  
end
