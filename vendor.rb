require 'rubygems'

$:.unshift(File.dirname(__FILE__) + '/vendor/webrat/lib')
$:.unshift(File.dirname(__FILE__) + '/vendor/sinatra/lib')
$:.unshift(File.dirname(__FILE__) + '/vendor/haml/lib')
$:.unshift(File.dirname(__FILE__) + '/vendor/couchrest/lib')
$:.unshift(File.dirname(__FILE__) + '/vendor/rest-client/lib')
$:.unshift(File.dirname(__FILE__) + '/vendor/extlib/lib')

require 'sinatra'
require 'couchrest'