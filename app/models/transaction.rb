class Transaction < ActiveRecord::Base
  before_create :add_token
  
  belongs_to :lender, :class_name => 'User'
  belongs_to :debtor, :class_name => 'User'
  belongs_to :currency
  
  validates :debtor_id, :lender_id, :amount, :currency_id, :presence => true
  
  def user_is_debtor?(current_user)
    self.debtor_id == current_user.id
  end
  
  def status
    if self.settled_lender
      'Cerrada por Prestador'
    elsif self.settled_debtor
      'Pagada por Deudor'
    elsif self.payment_requested
      'Pago pedido'
    else
      'Esperando pago'
    end
  end

  private

    def add_token
      begin
        self.token = SecureRandom.hex[0,10].upcase
      end while self.class.exists?(token: token)
    end
  
end
