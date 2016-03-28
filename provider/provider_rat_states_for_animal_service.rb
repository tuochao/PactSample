Pact.provider_states_for 'animal App' do

  provider_state "a rat exists" do
    set_up do
      # Create a thing here using your framework of choice
      # eg. Sequel.sqlite[:somethings].insert(name: "A small something")
    end

    tear_down do
      # Any tear down steps to clean up your code
    end
  end

  provider_state "a rat does not exist" do
    # If there's nothing to do because the state name is more for documentation purposes,
    # you can use no_op to imply this.
    set_up do
      # Create a thing here using your framework of choice
      # eg. Sequel.sqlite[:somethings].insert(name: "A small something")
      #puts '*****************'
    end

    tear_down do
      # Any tear down steps to clean up your code
    end
  end

end