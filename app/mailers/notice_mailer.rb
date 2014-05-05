# coding: utf-8
class NoticeMailer < ActionMailer::Base
	default from: "hhanckes@gmail.com"
  
  def send_invite_mail_to_lender(transaction)
    @transaction = transaction
  	mail to: transaction.lender.email, subject: "¡Prestaste dinero y lo tenemos registrado!"
  end

  def send_invite_mail_to_debtor(transaction)
    @transaction = transaction
  	mail to: transaction.lender.email, subject: "¡Debes dinero y lo tenemos registrado!"
  end

  def debt_paid_notification(transaction)
    @transaction = transaction
    mail to: transaction.lender.email, subject: "¡Te han pagado la deuda! Por favor confirma que recibiste los fondos"
  end
  
  def debt_payment_confirmed_notification(transaction)
    @transaction = transaction
    mail to: transaction.debtor.email, subject: "¡Ha llegado OK el pago de tu deuda!"
  end
  
  def debt_payment_requested_notification(transaction)
    @transaction = transaction
    mail to: transaction.debtor, subject: "¡Llegó el momento de pagar tu deuda!"
  end
  
end