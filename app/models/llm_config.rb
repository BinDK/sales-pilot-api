class LlmConfig < ApplicationRecord
  belongs_to :company
  acts_as_tenant :company
  encrypts :api_key
end
