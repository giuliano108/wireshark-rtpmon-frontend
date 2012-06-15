require 'rubygems'
require 'bundler/setup'
require 'sinatra'

require File.join(File.dirname(__FILE__), 'environment')

error do
    e = request.env['sinatra.error']
    Kernel.puts e.backtrace.join("\n")
    'Application error'
end

# root page
get '/' do
    haml :root
end

get '/data/:format' do
    last_index = 0
    File.open(DataPath+'/rtpmonlast.txt','r') { |file| last_index = file.gets.to_i }
    @reader = RtpmonReader.new(DataPath+'/'+("rtpmon%05d.bin" % last_index))
    if params[:format] == 'html'
        haml :table, :layout => false
    else
        content_type :text
        "OK"
    end
end
