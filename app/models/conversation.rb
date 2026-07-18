class Conversation < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  acts_as_tenant :company
end
