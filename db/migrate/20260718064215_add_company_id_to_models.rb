class AddCompanyIdToModels < ActiveRecord::Migration[8.1]
  def change
    add_reference :conversations, :company, foreign_key: true, null: false
    add_reference :orders, :company, foreign_key: true, null: false
    add_reference :timeline_events, :company, foreign_key: true, null: false
    add_reference :todos, :company, foreign_key: true, null: false
    add_reference :kpis, :company, foreign_key: true, null: false
  end
end
