# In /spec/service_providers/animal_service_client_spec.rb

# When using RSpec, use the metadata `:pact => true` to include all the pact functionality in your spec.
# When using Minitest, include Pact::Consumer::Minitest in your spec.
require "spec_helper"
require "animal_client"
require "health_client"
require "mock_animal_service"
require "mock_health_service"
require "cat"

describe AnimalClient, :pact => true do

  let(:animal_service_client) { AnimalClient.new }
  before do
    # Configure your client to point to the stub service on localhost using the port you have specified
    #subject { AnimalClient.new }
    AnimalClient.base_uri 'localhost:1234'
  end

  describe "get rat" do
    context "when a rat exists" do
      before do
        animal_service.given("a rat exists").
            upon_receiving("a request for a rat").
            with(method: 'get', path: '/rat', query: '').
            will_respond_with(
                status: 200,
                headers: {'Content-Type' => 'application/json'},
                body: {
                    'rat_name': 'Jerry',
                    'age': '8'
                })
      end
      it "returns a rat" do
        expect(animal_service_client.get_rat).to eq(Rat.new('Jerry'))
      end
    end

    context "when animal type isn't specified" do
      before do
        animal_service.given("a rat does not exist").
            upon_receiving("a request for a rat")
            .with(method: 'get', path: '/', ).
            will_respond_with(
                status: 404,
                headers: {'Content-Type' => 'application/json'},
                body: {'error': 'Request failed!'})
      end
      it "returns error message" do
        expect(animal_service_client.get_failed).to eq("Request failed!")
      end
    end

  end
end

describe HealthClient, :pact => true do

  let(:health_service_client) { HealthClient.new }
  before do
    # Configure your client to point to the stub service on localhost using the port you have specified
    subject { HealthClient.new }
    HealthClient.base_uri 'localhost:2345'
  end

  describe "get_rat_weight" do
    context "when rat weight exists" do
      before do
        health_service.given("rat weight exists").
            upon_receiving("a request for rat weight").
            with(method: 'get', path: '/rat', query: '').
            will_respond_with(
                status: 200,
                headers: {'Content-Type' => 'application/json'},
                body: {
                    "rat_weight": Pact.term(
                        generate: "5kg",
                        matcher: /\d+kg/
                    )} )
      end

      it "returns rat weight" do
        jerry = Rat.new('Jerry')
        jerry.weight = '5kg'
        puts subject.get_weight('/rat')
        expect(health_service_client.get_weight('/rat')).to eq(jerry.weight)
      end
    end

  end
end
