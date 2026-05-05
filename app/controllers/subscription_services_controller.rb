class SubscriptionServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription_service, only: %i[ show edit update destroy ]

  def index
    @subscription_services = current_user.subscription_services
    this_month_payment_services = current_user.this_month_payment_services
    @this_month_payment = this_month_payment_services.map do |service|
      service.price_to_jpy
    end.sum
  end

  def show
  end

  def new
    @subscription_service = SubscriptionService.new
  end

  def edit
  end

  def create
    @subscription_service = current_user.subscription_services.new(subscription_service_params)

    respond_to do |format|
      if @subscription_service.save
        format.html { redirect_to subscription_services_path, notice: I18n.t(:created, scope: [ :defaults, :messages ], attribute: SubscriptionService.model_name.human) }
        format.json { render :show, status: :created, location: @subscription_service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subscription_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscription_services/1 or /subscription_services/1.json
  def update
    respond_to do |format|
      if @subscription_service.update(subscription_service_params)
        format.html { redirect_to subscription_services_path, notice: I18n.t(:updated, scope: [ :defaults, :messages ], attribute: SubscriptionService.model_name.human) }
        format.json { render :show, status: :ok, location: @subscription_service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription_service.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription_service.destroy!

    respond_to do |format|
      format.html { redirect_to subscription_services_path, notice: I18n.t(:destroyed, scope: [ :defaults, :messages ], attribute: SubscriptionService.model_name.human) }
      format.json { head :no_content }
    end
  end

  def search
    @presets = Admin::ServicePreset.where("name ILIKE ?", "%#{params[:q]}%")

    respond_to do |format|
      format.js
    end
  end

  private
    def set_subscription_service
      @subscription_service = SubscriptionService.find(params.expect(:id))
    end

    def subscription_service_params
      params.expect(subscription_service: [ :name, :next_payment, :payment_interval, :payment_unit, :price, :monetary_unit ])
    end
end
