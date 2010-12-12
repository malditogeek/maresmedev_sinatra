require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'

module Demo
  class Application < Sinatra::Base

    get '/' do
      'Welcome!'
    end

    get '/hello/:name' do |name|
      "Hello #{name}!"
    end

  end
end
