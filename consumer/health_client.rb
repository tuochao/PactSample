require 'httparty'
require "cat"
require "rat"

class HealthClient
  include HTTParty
  base_uri = 'http://health-service.com'

  def get_weight(path)
    # Yet to be implemented because we're doing Test First Development...
    weight = 0
    if path == '/cat'
      weight = JSON.parse(self.class.get(path).body)['cat_weight']
    elsif path == '/rat'
      weight = JSON.parse(self.class.get(path).body)['rat_weight']
    end
  end

end