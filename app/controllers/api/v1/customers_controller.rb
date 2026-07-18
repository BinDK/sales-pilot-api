module Api
  module V1
    class CustomersController < BaseController
      def timeline
        customer = current_tenant.customers.find(params[:id])
        render json: customer.timeline_events
      end
    end
  end
end
