class TimelineEvent < ApplicationRecord
  belongs_to :customer
  acts_as_tenant :company
end
