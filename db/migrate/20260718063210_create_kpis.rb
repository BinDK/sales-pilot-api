class CreateKpis < ActiveRecord::Migration[8.1]
  def change
    create_table :kpis do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :period
      t.decimal :amount
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
