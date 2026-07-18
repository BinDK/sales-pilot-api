class Company < ApplicationRecord
  has_many :users
  has_many :llm_configs
  has_many :customers
end
