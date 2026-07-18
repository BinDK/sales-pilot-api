class Customer < ApplicationRecord
  belongs_to :company
  acts_as_tenant :company
  has_many :conversations
  has_many :orders
  has_many :timeline_events
end
