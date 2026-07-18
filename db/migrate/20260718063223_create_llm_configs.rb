class CreateLlmConfigs < ActiveRecord::Migration[8.1]
  def change
    create_table :llm_configs do |t|
      t.references :company, null: false, foreign_key: true
      t.string :provider
      t.string :api_key
      t.string :llm_model

      t.timestamps
    end
  end
end
