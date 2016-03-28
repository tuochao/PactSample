require 'pact/provider/rspec'
require './provider_cat_states_for_animal_service'
require './provider_rat_states_for_animal_service'
#require './provider_cat_states_for_health_service'
#require './provider_rat_states_for_health_service'

Pact.service_provider "Animal Service" do

  honours_pact_with 'Animal App' do

    # This example points to a local file, however, on a real project with a continuous
    # integration box, you would use a [Pact Broker](https://github.com/bethesque/pact_broker) or publish your pacts as artifacts,
    # and point the pact_uri to the pact published by the last successful build.

    pact_uri '../consumer/spec/pacts/animal_app-animal_service.json'
  end
end


Pact.service_provider "Health Service" do

  honours_pact_with 'Animal App' do

    # This example points to a local file, however, on a real project with a continuous
    # integration box, you would use a [Pact Broker](https://github.com/bethesque/pact_broker) or publish your pacts as artifacts,
    # and point the pact_uri to the pact published by the last successful build.

    pact_uri '../consumer/spec/pacts/animal_app-health_service.json'
  end
end
