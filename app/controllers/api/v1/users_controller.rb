module Api
  module V1
    class UsersController < BaseController
      before_action :require_admin
      
      def create
        # For admin creating sales, or super_admin creating admin
        user = User.new(user_params)
        if current_user.admin?
          user.role = :sales 
          user.company = current_user.company
        end
        
        if user.save
          render json: user.as_json(except: :password_digest), status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      private
      def user_params
        params.require(:user).permit(:email, :password, :role, :company_id)
      end
    end
  end
end
