$:.unshift(File.dirname(__FILE__) + '/../vendor/couchrest/lib')
$:.unshift(File.dirname(__FILE__) + '/../vendor/rest-client/lib')
$:.unshift(File.dirname(__FILE__) + '/../vendor/extlib/lib')
$:.unshift(File.dirname(__FILE__) + '/../models')

require 'rubygems'
require 'spec'
require 'couchrest'
require 'topic_map'

BASE_IRI = 'http://spec.host'
DB = 'http://localhost:5984/juristopia_spec'

T = TopicMap::Topic 
A = TopicMap::Association
O = TopicMap::Occurrence

describe TopicMap::Topic do
  
  before(:all) do
    CouchRest.delete(DB)
    CouchRest.database!(DB)
    CouchRest::Model.default_database = CouchRest.database!(DB)
    @topic = T.new
  end
  
  describe "a new topic" do
    it "should be a new_record" do
      @topic.rev.should be_nil
      @topic.should be_a_new_record
    end       
  
    it "should save" do
      @topic.save
      T.get(@topic.id).id.should == @topic.id
    end    
  end
  
  describe "a topic with a name" do
    it "should have a psi" do
      @topic.name = 'aName'
      @topic.psi.should == BASE_IRI + '/' + @topic.name
    end
  end
  
end

describe TopicMap::Association do
  it "should have a name" do
    pending
  end
  it "should have a type" do
    pending
  end
  it "should have a player" do
    pending
  end
  it "could have more players" do
    pending
  end  
end

describe TopicMap::Occurrence do
  it "should have a type" do
    pending
  end  
  it "should have content" do
    pending
  end    
end