require 'rubygems'
require 'bundler/setup'
require 'sinatra'

get '/hello' do
  'Hello world!'
end
