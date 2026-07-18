module Api
  module V1
    class TodosController < BaseController
      def index
        render json: current_user.todos
      end
    end
  end
end
