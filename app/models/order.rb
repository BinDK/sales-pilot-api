class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  acts_as_tenant :company
  enum :status, { pending: 0, completed: 1, cancelled: 2 }
end
