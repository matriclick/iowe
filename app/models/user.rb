# encoding: UTF-8
include ActionView::Helpers::NumberHelper
class User < ActiveRecord::Base
  has_many :debts, :class_name => 'Transaction', :foreign_key => 'debtor_id'
  has_many :loans, :class_name => 'Transaction', :foreign_key => 'lender_id'
  has_one :payment_profile
  has_one :account_configuration
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def self.show_consolidated_debt_tree(root, html, parent, first_time, debt = 0)
    html << ''
    if root.get_who_i_owe.size == 0 or (root == parent and !first_time)
      html << "<li><span><i class='icon-leaf'></i> #{root.email} <br>#{text(debt)} #{number_to_currency(debt.abs, precision: 0) if debt != 0} al padre</span> <a href="">Goes somewhere</a>"
      return html.html_safe
    else
      if first_time
        html << "<span><i class='icon-folder-open'></i> #{root.email}</span> <a href="">Goes somewhere</a>"
      else
        html << "<li><span><i class='icon-minus-sign'></i> #{root.email} <br>#{text(debt)} #{number_to_currency(debt.abs, precision: 0) if debt != 0} al padre</span> <a href="">Goes somewhere</a>"
      end
      html << "<ul>"
      for template_child in root.get_who_i_owe 
        temp_html = ''
        html << "#{show_consolidated_debt_tree(template_child.lender, temp_html, parent, false, root.get_consolidated_debt_with(template_child.lender))}</li>"
      end
      html << "</ul>"
    end
    return html.html_safe
  end

  def get_who_i_owe
    self.debts.joins(:debtor).select(:lender_id).uniq
  end
  
  def loans_with_payment_requested
    self.loans.where('payment_requested = ?', true)
  end
  
  def loans_waiting_for_settlement
    self.loans.where('settled_debtor = ? and (settled_lender = ? or settled_lender is ?)', true, false, nil)
  end
  
  def debts_waiting_for_settlement
    self.debts.where('settled_debtor = ? and (settled_lender = ? or settled_lender is ?)', true, false, nil)
  end
  
  def is_admin?
    false
  end
  
  def get_active_loans
    self.loans.where('(settled_lender = ? or settled_lender is ?)', false, nil)
  end
  
  def get_active_debts
    self.debts.where('(settled_lender = ? or settled_lender is ?)', false, nil)
  end
  
  def net_transactions
    self.loans.sum(:amount) - self.debts.sum(:amount)
  end
    
  def get_consolidated_debt_with(user)
    #lo que le debo al usuario (user me prestó plata)
    debts_with_user = self.debts.where('lender_id = ? and (settled_debtor = ? or settled_debtor is ?) and (settled_lender = ? or settled_lender is ?)', user.id, false, nil, false, nil).sum(:amount)
    #lo que le he prestado al usuario (user es el deudor)
    loans_with_user = self.loans.where('debtor_id = ? and (settled_debtor = ? or settled_debtor is ?) and (settled_lender = ? or settled_lender is ?)', user.id, false, nil, false, nil).sum(:amount)
    #lo que le he prestado menos lo que me debe; si es positivo el usuario me debe, si es negativo, le debo al usuario
    loans_with_user - debts_with_user
  end
  
  def self.text(amount)
    return 'Prestó' if amount < 0
    return 'Debe' if amount > 0
    return '' if amount == 0
  end
end
