# In /spec/service_providers/pact_helper.rb

require 'pact/consumer/rspec'
# or require 'pact/consumer/minitest' if you are using Minitest

Pact.service_consumer "animal App" do
  has_pact_with "Health Service" do
    mock_service :health_service do
      port 2345
    end
  end
end