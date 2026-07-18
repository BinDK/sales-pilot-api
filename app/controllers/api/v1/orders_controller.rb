module Api
  module V1
    class OrdersController < BaseController
      def index
        render json: current_tenant.orders
      end
    end
  end
end
