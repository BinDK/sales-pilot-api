class Todo < ApplicationRecord
  belongs_to :user
  acts_as_tenant :company
end
