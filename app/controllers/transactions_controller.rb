# encoding: UTF-8
class TransactionsController < ApplicationController
  before_action :authenticate_user!, except: [:mark_as_paid_by_debtor, :mark_as_paid_by_lender]
  before_action :set_transaction, only: [:show, :mark_as_paid_by_debtor, :mark_as_paid_by_lender, :ask_for_payment, :payment_requested, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.where('(lender_id = ? or debtor_id = ?)', current_user.id, current_user.id).order 'created_at DESC'
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    lender_email = params[:lender_email]
    lender = User.find_by_email lender_email
    send_invite_mail = false
    unless lender_email.blank?
      if lender.blank?
        send_invite_mail = true
        lender = User.create!({:email => lender_email, :password => "111111", :password_confirmation => "111111" })
      end
      params[:transaction][:lender_id] = lender.id 
    end
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        NoticeMailer.send_invite_mail(@transaction).deliver if send_invite_mail
        format.html { redirect_to user_root_path, notice: '¡Deuda creada correctamente!' }
        format.json { render action: 'show', status: :created, location: @transaction }
      else
        format.html { render action: 'new' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    lender_email = params[:lender_email]
    lender = User.find_by_email lender_email
    transaction_params[:lender_id] = lender.id
    
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: '¡Deuda actualizada correctamente!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def mark_as_paid_by_debtor
    redirect_to(user_root_path, notice: '¡No tienes permiso para realizar esta acción!') and return if !signed_in_or_token_valid?
    
    @transaction.update_attribute :settled_debtor, true
    NoticeMailer.debt_paid_notification(@transaction).deliver
    respond_to do |format|
      format.html { redirect_to user_root_path, notice: 'Se ha enviado un correo al Prestador para que confirme la recepción del pago.' }
      format.json { head :no_content }
    end
  end
  
  def mark_as_paid_by_lender
    redirect_to(user_root_path, notice: '¡No tienes permiso para realizar esta acción!') and return if !signed_in_or_token_valid?
    
    @transaction.update_attribute :settled_lender, true
    NoticeMailer.debt_payment_confirmed_notification(@transaction).deliver
    respond_to do |format|
      format.html { redirect_to user_root_path, notice: 'Se ha enviado un correo al Deudor para confirmar que llegó OK el pago' }
      format.json { head :no_content }
    end
  end
  
  def ask_for_payment
    @transaction.update_attribute :payment_requested, true
    NoticeMailer.debt_payment_requested_notification(@transaction).deliver
    respond_to do |format|
      format.html { redirect_to user_root_path, notice: 'Se ha enviado un correo al Deudor con los datos para que pague' }
      format.json { head :no_content }
    end
  end
  
  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:debtor_id, :lender_id, :amount, :currency_id, :comments)
    end
    
    def signed_in_or_token_valid?
      if user_signed_in?
        true
      else
        if params[:token].empty?
          false
        else
          if @transaction.token == params[:token]
            true
          else
            false
          end
        end
      end
    end
    
end
