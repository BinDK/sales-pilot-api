models_dir = 'app/models'

def update_model(file_path, insertions)
  content = File.read(file_path)
  # Insert before the last end
  content.sub!(/^end\s*\z/, insertions + "\nend\n")
  File.write(file_path, content)
end

update_model("#{models_dir}/user.rb", "  has_secure_password\n  has_secure_token :auth_token\n  enum :role, { super_admin: 0, admin: 1, sales: 2 }\n  acts_as_tenant :company, optional: true\n  has_many :kpis\n  has_many :conversations\n  has_many :orders\n  has_many :todos")
update_model("#{models_dir}/company.rb", "  has_many :users\n  has_many :llm_configs\n  has_many :customers")
update_model("#{models_dir}/llm_config.rb", "  acts_as_tenant :company\n  encrypts :api_key")
update_model("#{models_dir}/kpi.rb", "  acts_as_tenant :company\n  enum :period, { month: 0, quarter: 1, year: 2 }")
update_model("#{models_dir}/customer.rb", "  acts_as_tenant :company\n  has_many :conversations\n  has_many :orders\n  has_many :timeline_events")
update_model("#{models_dir}/conversation.rb", "  acts_as_tenant :company")
update_model("#{models_dir}/order.rb", "  acts_as_tenant :company\n  enum :status, { pending: 0, completed: 1, cancelled: 2 }")
update_model("#{models_dir}/todo.rb", "  acts_as_tenant :company")
update_model("#{models_dir}/timeline_event.rb", "  acts_as_tenant :company")

puts "Models updated"
