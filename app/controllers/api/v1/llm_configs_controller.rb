module Api
  module V1
    class LlmConfigsController < BaseController
      before_action :require_admin
      
      def verify
        # Fake verification for now
        render json: { models: ["gpt-4o", "gpt-4-turbo", "claude-3-opus"] }
      end
      
      def create
        config = current_tenant.llm_configs.find_or_initialize_by(provider: params[:provider])
        config.update(api_key: params[:api_key], llm_model: params[:llm_model])
        if config.save
          render json: config, status: :created
        else
          render json: { errors: config.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
