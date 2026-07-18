class Kpi < ApplicationRecord
  belongs_to :user
  acts_as_tenant :company
  enum :period, { month: 0, quarter: 1, year: 2 }
end
