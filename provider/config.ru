require 'rack'
require './provider_cat_states_for_animal_service'
require './provider_rat_states_for_animal_service'
require './provider_cat_states_for_health_service'
require './provider_rat_states_for_health_service'
require './animal_service_api'

=begin
app_200 = Proc.new do |env|
  ['200', {'Content-Type' => 'application/json'}, ['{"cat_name": "Tom","rat_name": "Jerry","cat_weight": "10kg","rat_weight": "5kg"}']]
end
=end

run AnimalService::Api