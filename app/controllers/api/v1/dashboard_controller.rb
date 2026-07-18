module Api
  module V1
    class DashboardController < BaseController
      def index
        render json: {
          kpis: current_user.kpis,
          todays_summary: "Placeholder summary"
        }
      end
    end
  end
end
