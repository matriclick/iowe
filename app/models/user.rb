class User < ActiveRecord::Base
  has_many :debts, :class_name => 'Transaction', :foreign_key => 'debtor_id'
  has_many :loans, :class_name => 'Transaction', :foreign_key => 'lender_id'
  has_one :payment_profile
  has_one :account_configuration
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
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
  
end
