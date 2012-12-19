require "bundler/setup"
Bundler.require
require_relative "start_mc_server.rb"


use Rack::Auth::Basic, "Halt who goes there!" do |username, password|
  [username, password] == ['minecraft', 'serverup']
end

get '/' do
  @aws = AmazonWrapper.new
  erb :show
end
get '/stop' do
  @aws = AmazonWrapper.new
  @aws.stop_mc
  redirect '/'
end
get '/start' do
  @aws = AmazonWrapper.new
  @aws.start_mc
  redirect '/'
end
get '/assign_ip' do
  @aws = AmazonWrapper.new
  @aws.assign_ip
  redirect '/'
end