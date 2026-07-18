module Api
  module V1
    class BaseController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      
      before_action :authenticate_user
      before_action :set_tenant

      attr_reader :current_user

      private

      def authenticate_user
        authenticate_with_http_token do |token, options|
          @current_user = User.find_by(auth_token: token)
        end

        render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
      end

      def set_tenant
        if @current_user&.company_id
          set_current_tenant(@current_user.company)
        end
      end
      
      def require_super_admin
        render json: { error: 'Forbidden' }, status: :forbidden unless current_user.super_admin?
      end

      def require_admin
        render json: { error: 'Forbidden' }, status: :forbidden unless current_user.super_admin? || current_user.admin?
      end
    end
  end
end
