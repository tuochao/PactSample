Pact.provider_states_for 'animal App' do

  provider_state "cat weight exists" do
    set_up do
      # Create a thing here using your framework of choice
      # eg. Sequel.sqlite[:somethings].insert(name: "A small something")
    end

    tear_down do
      # Any tear down steps to clean up your code
    end
  end
end