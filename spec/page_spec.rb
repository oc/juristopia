$:.unshift(File.dirname(__FILE__) + '/../vendor/couchrest/lib')
$:.unshift(File.dirname(__FILE__) + '/../vendor/rest-client/lib')
$:.unshift(File.dirname(__FILE__) + '/../vendor/extlib/lib')
$:.unshift(File.dirname(__FILE__) + '/../models')

require 'rubygems'
require 'spec'
require 'couchrest'
require 'topic_map'
require 'page'

BASE_IRI = 'http://spec.host'
DB = 'http://localhost:5984/juristopia_spec'
describe Page do
  before(:all) do
    CouchRest.delete(DB)
    CouchRest.database!(DB)
    CouchRest::Model.default_database = CouchRest.database!(DB)
  end
  
  describe "a new page" do
    it "should be a new_record" do
      @obj = Page.new
      @obj.rev.should be_nil
      @obj.should be_a_new_record
    end       
  end
  
  describe "a page without a name" do
    it "should not save" do
      @p = Page.new
      lambda{@p.save}.should raise_error
    end    
  end
  
  describe "a page with a name" do    
    it "should have a name" do
      @p = Page.new(:name => "aName")
      @p.name.should == 'aName'
    end  
    
    it "should have a psi" do
      @p = Page.new(:name => 'aName')
      @p.psi.should == BASE_IRI + '/' + 'aName'
    end  
    
    it "should save" do
      Page.new(:name => 'aSavedPage').save
      @page = Page.by_name(:key => 'aSavedPage')[0]
      @page.name.should == 'aSavedPage'
    end
  end
  
  describe "a page without a specified type" do
    it "should have :page type" do
      @p = Page.new
      @p.type.should == :page
    end
  end
  
  describe "a page with a specified type" do
    it "should not accept illegal types" do
      @page = Page.new
      @page.type = :illegal
      @page.type.should == :page
    end
    
    it "should not accept illegal types" do
      @page = Page.new
      @page.type = :association_type
      @page.type.should == :association_type
    end
  end

end

