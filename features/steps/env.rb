require 'spec'

$0 = File.dirname(__FILE__) + '/../../juristopia.rb' # Otherwise Sinatra will look for views in the wrong place
require File.dirname(__FILE__) + '/../../vendor'
require 'webrat/sinatra/sinatra_session'
require 'sinatra/test/common'
require 'couchrest/commands/push'
require File.dirname(__FILE__) + '/../../juristopia'

World do
  #CouchRest::Model.default_database = CouchRest.database!("juristopia_test")
  Webrat::SinatraSession.new
end
