require "swagger_helper"

RSpec.describe "API V1", type: :request do
  path "/api/v1/login" do
    post("Authenticate User") do
      tags "Auth"
      consumes "application/json"
      produces "application/json"
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: "admin@company.com" },
          password: { type: :string, example: "password123" }
        },
        required: [ "email", "password" ]
      }

      response(200, "successful") do
        schema type: :object, properties: {
          token: { type: :string, example: "abc123token" },
          user: {
            type: :object,
            properties: {
              id: { type: :integer, example: 1 },
              email: { type: :string, example: "admin@company.com" },
              role: { type: :string, example: "admin" },
              company_id: { type: :integer, example: 1 }
            }
          }
        }
        run_test!
      end
      response(401, "unauthorized") do
        schema type: :object, properties: { error: { type: :string, example: "Invalid email or password" } }
        run_test!
      end
    end
  end

  path "/api/v1/companies" do
    post("Create Company") do
      tags "Companies"
      security [ bearer_auth: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :company, in: :body, schema: {
        type: :object,
        properties: {
          company: {
            type: :object,
            properties: { name: { type: :string, example: "Acme Corp" } },
            required: ["name"]
          }
        }
      }

      response(201, "created") do
        schema type: :object, properties: {
          id: { type: :integer, example: 1 },
          name: { type: :string, example: "Acme Corp" }
        }
        run_test!
      end
    end
  end

  path "/api/v1/users" do
    post("Create User (Sales/Admin)") do
      tags "Users"
      security [ bearer_auth: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: "sales@acme.com" },
              password: { type: :string, example: "password123" },
              role: { type: :string, example: "sales" },
              company_id: { type: :integer, example: 1 }
            },
            required: ["email", "password", "role"]
          }
        }
      }

      response(201, "created") do
        schema type: :object, properties: {
          id: { type: :integer, example: 2 },
          email: { type: :string, example: "sales@acme.com" },
          role: { type: :string, example: "sales" },
          company_id: { type: :integer, example: 1 }
        }
        run_test!
      end
    end
  end

  path "/api/v1/llm_configs/verify" do
    post("Verify LLM Models") do
      tags "LLM Configuration"
      security [ bearer_auth: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :verify_payload, in: :body, schema: {
        type: :object,
        properties: {
          provider: { type: :string, example: "openai" },
          api_key: { type: :string, example: "sk-..." }
        },
        required: ["provider", "api_key"]
      }

      response(200, "successful") do
        schema type: :object, properties: {
          models: { type: :array, items: { type: :string }, example: ["gpt-4o", "gpt-4-turbo", "claude-3-opus"] }
        }
        run_test!
      end
    end
  end

  path "/api/v1/llm_configs" do
    post("Save LLM Configuration") do
      tags "LLM Configuration"
      security [ bearer_auth: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :config_payload, in: :body, schema: {
        type: :object,
        properties: {
          provider: { type: :string, example: "openai" },
          api_key: { type: :string, example: "sk-..." },
          llm_model: { type: :string, example: "gpt-4o" }
        },
        required: ["provider", "api_key", "llm_model"]
      }

      response(201, "created") do
        schema type: :object, properties: {
          id: { type: :integer, example: 1 },
          provider: { type: :string, example: "openai" },
          llm_model: { type: :string, example: "gpt-4o" }
        }
        run_test!
      end
    end
  end

  path "/api/v1/dashboard" do
    get("Sales Dashboard Summary") do
      tags "Dashboard"
      security [ bearer_auth: [] ]
      produces "application/json"

      response(200, "successful") do
        schema type: :object, properties: {
          kpis: { type: :array, items: { type: :object }, example: [] },
          todays_summary: { type: :string, example: "Placeholder summary" }
        }
        run_test!
      end
    end
  end

  path "/api/v1/conversations" do
    get("List Conversations") do
      tags "Conversations"
      security [ bearer_auth: [] ]
      produces "application/json"

      response(200, "successful") do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer, example: 1 },
            customer_id: { type: :integer, example: 10 },
            user_id: { type: :integer, example: 2 },
            content: { type: :string, example: "Customer asked about pricing..." },
            ai_summary: { type: :string, example: "Pricing inquiry" },
            company_id: { type: :integer, example: 1 }
          }
        }
        run_test!
      end
    end
  end

  path "/api/v1/conversations/{id}/summarize" do
    post("Summarize Conversation") do
      tags "Conversations"
      security [ bearer_auth: [] ]
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, required: true, description: "Conversation ID", example: 1

      response(200, "successful") do
        schema type: :object, properties: {
          id: { type: :integer, example: 1 },
          content: { type: :string, example: "Customer asked about pricing..." },
          ai_summary: { type: :string, example: "AI generated summary of conversation ID 1" }
        }
        run_test!
      end
    end
  end

path "/api/v1/kpis" do
  post("Create KPI") do
    tags "KPIs"
    security [ bearer_auth: [] ]
    consumes "application/json"
    produces "application/json"
    parameter name: :kpi, in: :body, schema: {
      type: :object,
      properties: {
        kpi: {
          type: :object,
          properties: {
            user_id: { type: :integer, example: 2 },
            period: { type: :string, example: "month" },
            amount: { type: :number, example: 10000.0 },
            start_date: { type: :string, example: "2023-01-01" },
            end_date: { type: :string, example: "2023-01-31" }
          }
        }
      }
    }

    response(201, "created") do
      run_test!
    end
  end
end

path "/api/v1/orders" do
  get("List Orders") do
    tags "Orders"
    security [ bearer_auth: [] ]
    produces "application/json"

    response(200, "successful") do
      run_test!
    end
  end
end

path "/api/v1/todos" do
  get("List Todos") do
    tags "Todos"
    security [ bearer_auth: [] ]
    produces "application/json"

    response(200, "successful") do
      run_test!
    end
  end
end

path "/api/v1/customers/{id}/timeline" do
  get("Customer Timeline") do
    tags "Customers"
    security [ bearer_auth: [] ]
    produces "application/json"
    parameter name: :id, in: :path, type: :integer, required: true, example: 1

    response(200, "successful") do
      run_test!
    end
  end
end
end
