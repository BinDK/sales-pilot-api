module Api
  module V1
    class ConversationsController < BaseController
      def index
        render json: Conversation.all
      end
      
      def summarize
        conversation = Conversation.find(params[:id])
        # Trigger background job or inline for hackathon
        conversation.update(ai_summary: "AI generated summary of conversation ID #{conversation.id}")
        render json: conversation
      end
    end
  end
end
