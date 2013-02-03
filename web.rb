
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
require 'net/http'

module Foo

  module Constants
    module Wiki
      # MEDIAWIKI::API
      # http://www.mediawiki.org/wiki/API:Main_page
      # formats: 
      # JSON/YAML
      # api.php ? action=query & titles=Albert%20Einstein & prop=info & format=jsonfm
      # XML
      # api.php ? action=query & titles=Albert%20Einstein & prop=info & format=xmlfm
      ENDPOINT = "http://en.wikipedia.org/w/api.php"
      FORMATS = ['json', 'xml', 'jaml']
      # meh...
      TRAIL = "&prop=revisions&rvprop=content"
      def self.included(klass)
        # ...
      end
    end
  end
  
  class Query
    # sample:
    # http://en.wikipedia.org/w/api.php?format=xml&action=query&titles=Main%20Page&prop=revisions&rvprop=content

    include Constants::Wiki

    attr_accessor :format, :action, :titles, :url

    # TODO: move in utils

    def initialize(titles, format='json')
      @url = URI.parse "#{Constants::Wiki::ENDPOINT}?format=#{format}&action=query&titles=#{titles}#{Constants::Wiki::TRAIL}"
    end

    def fire
      net = Net::HTTP.new(@url.host, @url.port)
      net.use_ssl = false
      query = Net::HTTP::Get.new(@url.path + '?' + @url.query)
      response = net.request(query)
      case response
        when Net::HTTPBadResponse
          puts "Net::HTTPBadResponse ??"
        when Net::HTTPRedirection
          # TODO: manage wikiredirect
        else
          # puts "Response code: #{response.code} message: #{response.message} body: #{response.body}"
          response.tap{|r| p "#{r.class}"}.body.force_encoding('UTF-8').to_json
      end
    end

    private
    def self.validate
      #TODO: implement_me
    end

  end

  class API < Grape::API

    # version 'v1', :using => :header, :vendor => 'foo_corp'
    format :json
    content_type :txt, "text/plain"
    default_error_formatter :txt
    
    helpers do
      def logger
        API.logger
      end
    end

    get '/' do
      {:home => 'home_page', :time => Time.now}.to_json
    end

    get '/todo' do
      {:todo => ['haml template']}
    end

    resource 'wiki' do
      desc "Get the JSON file for the Wikipedia Main Page"
      get 'main' do
        #en.wikipedia.org/w/api.php?format=json&action=query&titles=Main_Page&prop=revisions&rvprop=content
        # Query.new('Main_Page').fire
        Query.new('Main_Page', 'jsonfm').tap{|q| logger.info "... firing #{q.url}" }.fire
      end
      desc "Get a JSON page from Wikipedia"
      get '/:title' do
        Query.new(params[:title]).tap{|q| logger.info "... firing #{q.url}" }.fire
      end
    end

    resource 'foos' do
      get '/' do
        { :hello => 'Grape'}.to_json
      end
      get ':alpha' do
        "the ALPHA Foo!"
      end
      get '/show/:id' do
        Foo.find params[:id]
      end
    end

  end
end
