
# using Sinatra... 
# https://github.com/sinatra/sinatra 
# filename: web.rb
# require 'sinatra'
# get '/' do
#   "Hello, world"
# end

# ... or Grape...
# https://github.com/intridea/grape
require 'grape'
require 'json'

module Foo
  class API < Grape::API

    # version 'v1', :using => :header, :vendor => 'foo-corp'
    format :json

    get '/' do
      {:home => 'home_page', :time => Time.now}.to_json
    end

    resource 'foos' do

      get '/' do
        { :hello => 'Grape'}.to_json
      end
  
      get :alpha do
        "the ALPHA Foo!"
      end
  
      get '/show/:id' do
        Foo.find params[:id]
      end
  
    end
  end
end
