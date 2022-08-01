# frozen_string_literal: true

# alerts controller
class AlertsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_alert, only: :destroy

  # GET /alerts
  # params[:status] = created/deleted/triggered
  def index
    # @alerts = Alert.filtered_alerts(current_user, params[:status])
    alerts_ids = Rails.cache.fetch('alerts_ids', expires_in: 2.hours) do
                   Alert.filtered_alerts(current_user, params[:status]).pluck(:id)
                 end
    _pagy, alerts = pagy(Alert.where(id: alerts_ids), items: per_page)
    render json: alerts, except: %i[created_at deleted_at updated_at]
  end

  # POST /alerts
  # params[:price]
  def create
    @alert = current_user.alerts.build(alert_params)
    if @alert.save
      render json: @alert
    else
      render json: @alert.errors.full_messages
    end
  end

  # DELETE /alerts/:id
  def destroy
    if @alert.destroy
      render json: 'Alert deleted!', status: :ok
    else
      render json: @alert.errors.full_messages
    end
  end

  private

  def alert_params
    params.require(:alert).permit(
      :price
    )
  end

  def find_alert
    @alert = current_user.alerts.find_by_id(params[:id])
  end
end
