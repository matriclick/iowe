# coding: utf-8
class NoticeMailer < ActionMailer::Base
	default from: "hhanckes@gmail.com"
  
  def send_invite_mail_to_lender(transaction)
    @transaction = transaction
  	mail to: transaction.lender.email, bcc: "hhanckes@gmail.com", subject: "¡Prestaste dinero y lo tenemos registrado!"
  end

  def send_invite_mail_to_debtor(transaction)
    @transaction = transaction
  	mail to: transaction.lender.email, bcc: "hhanckes@gmail.com", subject: "¡Prestaste dinero y lo tenemos registrado!"
  end

  def debt_paid_notification(transaction)
    @transaction = transaction
    mail to: transaction.lender.email, cc: transaction.debtor.email, bcc: "hhanckes@gmail.com", subject: "¡Te han pagado la deuda!"
  end
  
  def debt_payment_confirmed_notification(transaction)
    @transaction = transaction
    mail to: transaction.lender.email, cc: transaction.debtor.email, bcc: "hhanckes@gmail.com", subject: "¡Ha llegado OK el pago de tu deuda!"
  end
  
  def debt_payment_requested_notification(transaction)
    @transaction = transaction
    mail to: transaction.debtor.email, cc: transaction.lender.email, bcc: "hhanckes@gmail.com", subject: "¡Llegó el momento de pagar tu deuda!"
  end
  
end