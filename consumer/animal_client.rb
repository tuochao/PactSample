require 'httparty'
require "cat"
require "rat"

class AnimalClient
  include HTTParty
  base_uri = 'http://animal-service.com'

  def get_cat
    # Yet to be implemented because we're doing Test First Development...
    name = JSON.parse(self.class.get("/cat").body)['cat_name']
    Cat.new(name)
  end

  def get_rat
    # Yet to be implemented because we're doing Test First Development...
    name = JSON.parse(self.class.get("/rat").body)['rat_name']
    Rat.new(name)
  end

  def get_failed
    self.class.get("/").body
    "Request failed!"
  end

end