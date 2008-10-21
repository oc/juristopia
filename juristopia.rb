$KCODE='u'
require File.dirname(__FILE__) + '/vendor'
$:.unshift(File.dirname(__FILE__) + '/models')
require 'string_ext'
require 'topic_map'
require 'page'
require 'helper'

unless Sinatra.application.reloading?
  BASE_IRI = 'http://localhost:4567'
  DB = 'http://localhost:5984/juristopia'
  CouchRest::Model.default_database = CouchRest.database!(DB)
end

PAGE_TYPES = [:page, :association_type, :occurrence_type]

before do
  content_type "text/html;charset=utf-8"
end

get '/' do
  redirect '/' + 'Welcome'
end

post '/_q' do
  @pages = Page.by_content(:key => params[:query])
  haml :list
end

get '/:name' do
  @page = Page.by_name(:key => params[:name])[0]
  raise Sinatra::NotFound if @page.nil? or @page.empty?
  @page = Helper.parse(@page)
  if PAGE_TYPES.include? @page.type
    haml @page.type
  else
    haml :page
  end
end

get '/:name/edit' do
  @page = Page.by_name(:key => params[:name])[0]
  @page = Page.new(:name => params[:name], :content => '') if @page.nil? or @page.empty?
  haml :edit_page
end

# POST = save
post '/:name' do
  page = Page.create!(params)
  redirect '/' + page.name
end  

get '/juristopia.css' do
  content_type 'text/css;charset=utf-8'
  sass :juristopia
end

get '/juristopia.js' do
  content_type 'text/javascript;charset=utf-8'
  File.read(File.dirname(__FILE__) + "/javascripts/juristopia.js")
end

get '/assets/:image.png' do
  content_type :png
  File.read(File.dirname(__FILE__) + "/assets/#{params[:image]}.png")
end

not_found do
  @name = params[:name]
  @content = "#{params[:name]} doesn't exist yet, do you wish to <a href='/#{params[:name]}/edit'>create it?</a> "
  haml :not_found  
end
