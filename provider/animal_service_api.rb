require 'sinatra/base'
require 'json'

module AnimalService

  class Api < Sinatra::Base

    set :raise_errors, false
    set :show_exceptions, false

    error do
      e = env['sinatra.error']
      content_type :json
      status 500
      {error: e.message, backtrace: e.backtrace}.to_json
    end

    get '*' do
      puts "**********************************"
      puts params
      puts "********************************"
      content_type :'application/json'
      if params[:splat] == ['/cat'] or params[:splat] == ['/rat']
        status 200
        body = {"cat_name": "Tom","rat_name": "Jerry","cat_weight": "10kg","rat_weight": "5kg","age":"8"}
        return body.to_json
      else
        status 404
        body = {"error":"Request failed!"}
        return body.to_json
      end
    end

  end
end