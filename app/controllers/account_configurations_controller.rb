class AccountConfigurationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account_configuration, only: [:show, :edit, :update, :destroy]

  # GET /account_configurations
  # GET /account_configurations.json
  def index
    @account_configurations = AccountConfiguration.all
  end

  # GET /account_configurations/1
  # GET /account_configurations/1.json
  def show
  end

  # GET /account_configurations/new
  def new
    @account_configuration = AccountConfiguration.new
  end

  # GET /account_configurations/1/edit
  def edit
  end

  # POST /account_configurations
  # POST /account_configurations.json
  def create
    @account_configuration = AccountConfiguration.new(account_configuration_params)

    respond_to do |format|
      if @account_configuration.save
        format.html { redirect_to @account_configuration, notice: 'Account configuration was successfully created.' }
        format.json { render action: 'show', status: :created, location: @account_configuration }
      else
        format.html { render action: 'new' }
        format.json { render json: @account_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_configurations/1
  # PATCH/PUT /account_configurations/1.json
  def update
    respond_to do |format|
      if @account_configuration.update(account_configuration_params)
        format.html { redirect_to @account_configuration, notice: 'Account configuration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_configurations/1
  # DELETE /account_configurations/1.json
  def destroy
    @account_configuration.destroy
    respond_to do |format|
      format.html { redirect_to account_configurations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_configuration
      @account_configuration = AccountConfiguration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_configuration_params
      params.require(:account_configuration).permit(:user_id, :allow_netting, :collection_mail_frecuency_in_days)
    end
end
