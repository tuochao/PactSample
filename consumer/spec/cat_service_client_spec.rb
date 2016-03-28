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

  describe "get cat" do
    context "when a cat exists" do
        before do
          animal_service.given("a cat exists").
              upon_receiving("a request for a cat").
              with(method: 'get', path: '/cat', query: '').
              will_respond_with(
                  status: 200,
                  headers: {'Content-Type' => 'application/json'},
                  body: {
                      "cat_name": "Tom",
                      "age": "8"
                  })
        end
        it "returns a cat" do
          expect(animal_service_client.get_cat).to eq(Cat.new('Tom'))
        end
    end

    context "when animal type isn't specified" do
      before do
        animal_service.given("a cat does not exist").
            upon_receiving("a request for a cat").
            with(method: 'get', path: '/').
            will_respond_with(status: 404,
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
    #subject { HealthClient.new }
    HealthClient.base_uri 'localhost:2345'
  end

  describe "get_cat_weight" do
    context "when cat weight exists" do
      before do
        health_service.given("cat weight exists").
            upon_receiving("a request for cat weight").
            with(method: 'get', path: '/cat', query: '').
            will_respond_with(
                status: 200,
                headers: {'Content-Type' => 'application/json'},
                body: {"cat_weight": Pact.term(
                    generate: "10kg",
                    matcher: /\d+kg/
                )} )
      end

      it "returns cat weight" do
        tom = Cat.new('Tom')
        tom.weight = '10kg'
        puts subject.get_weight('/cat')
        expect(health_service_client.get_weight('/cat')).to eq(tom.weight)
      end
    end

  end
end
