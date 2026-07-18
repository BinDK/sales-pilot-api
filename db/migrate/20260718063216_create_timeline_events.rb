class CreateTimelineEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :timeline_events do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :action
      t.text :details

      t.timestamps
    end
  end
end
