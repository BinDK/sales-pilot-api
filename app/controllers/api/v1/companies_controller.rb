module Api
  module V1
    class CompaniesController < BaseController
      before_action :require_super_admin
      
      def create
        company = Company.new(company_params)
        if company.save
          render json: company, status: :created
        else
          render json: { errors: company.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      private
      def company_params
        params.require(:company).permit(:name)
      end
    end
  end
end
