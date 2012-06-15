require 'rubygems'
require 'bundler/setup'
require 'haml'
require 'ostruct'
require 'sinatra' unless defined?(Sinatra)
require 'sinatra/reloader' if development?
require 'ruby-debug' if development?
require 'json'
require 'bindata'
require File.join(File.dirname(__FILE__),'types')
require File.join(File.dirname(__FILE__),'structs')


configure do
    set :views, "#{File.dirname(__FILE__)}/views"
end

configure(:development) do 
    DataPath = "#{File.dirname(__FILE__)}/data"
end

configure(:production) do 
    DataPath = "#{File.dirname(__FILE__)}/data"
end

SiteConfig = OpenStruct.new(
             :title => 'rtpmon',
             :author => 'Giuliano Cioffi',
           )
