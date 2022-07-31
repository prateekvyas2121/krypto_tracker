class AlertsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_alert, only: :destroy
  

  def index
    @alerts = Alert.filtered_alerts(current_user, params[:status])
    render json: @alerts, except: [:created_at, :deleted_at, :updated_at]
  end

  def create
    @alert = current_user.alerts.build(alert_params)
    if @alert.save
      render json: @alert
    else
      render json: @alert.errors.full_messages
    end
  end

  def destroy
    if @alert.destroy
      render json: "Alert deleted!", status: :ok
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
