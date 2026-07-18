class User < ApplicationRecord
  belongs_to :company
  has_secure_password
  has_secure_token :auth_token
  enum :role, { super_admin: 0, admin: 1, sales: 2 }
  acts_as_tenant :company, optional: true
  has_many :kpis
  has_many :conversations
  has_many :orders
  has_many :todos
end
