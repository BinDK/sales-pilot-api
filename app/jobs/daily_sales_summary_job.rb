class DailySalesSummaryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Generate daily summary for each sales user
    User.sales.find_each do |sales_user|
      # Pseudo logic for AI generation
      summary = "AI Daily Summary for \#{sales_user.email} on \#{Date.today}"
      
      # For now, just create a Todo as proof of generation
      Todo.create!(
        user: sales_user,
        company: sales_user.company,
        title: "Review daily summary: \#{summary}",
        is_completed: false
      )
    end
  end
end
