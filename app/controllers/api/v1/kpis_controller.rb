module Api
  module V1
    class KpisController < BaseController
      before_action :require_admin
      
      def create
        kpi = current_tenant.kpis.new(kpi_params)
        if kpi.save
          render json: kpi, status: :created
        else
          render json: { errors: kpi.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      private
      def kpi_params
        params.require(:kpi).permit(:user_id, :period, :amount, :start_date, :end_date)
      end
    end
  end
end
