# require 'rubygems'
# $:.unshift(File.dirname(__FILE__) + '/../vendor/couchrest/lib')
# $:.unshift(File.dirname(__FILE__) + '/../vendor/rest-client/lib')
# $:.unshift(File.dirname(__FILE__) + '/../vendor/extlib/lib')
# require 'couchrest'
# 
# CouchRest::Model.default_database = CouchRest.database!('juristopia_tm')
# BASE_IRI = 'http://localhost:4567'



module TopicMap 
  class Topic < CouchRest::Model
    key_accessor :name
    
    view_by      :name
    
    def associations
      Association.by_name(:key => name)
    end
    
    def associations_by_type
      Association.by_type(:key => name)
    end
    
    def occurrences
      Occurrence.by_name(:key => name)
    end
    
    def occurrences_by_type
      Occurrence.by_type(:key => name)
    end    
    
    def psi
      BASE_IRI + '/' + name
    end
    
    def to_xml
      xml = %(<topic id="#{id}" name="#{name}" psi="#{psi}">)
      occurrences.each { |o| xml << o.to_xml }
      associations.each { |a| xml << a.to_xml }
      xml << "</topic>"
      xml
    end
  end
    
  class Occurrence < CouchRest::Model
    key_accessor :name, :type, :content
    view_by      :name
        
    def to_xml
      xml = ""
      xml << "<occurrence id='#{id}' ref='#{name}' type='#{type}'>"
      xml << "![CDATA[#{content}]]"
      xml << "</occurrence>"
      xml
    end
    
    def to_html
      "<dl class='occurrence'><dt>#{Helper.to_link(type)}</dt><dd class='content'>#{content}</dd></dl>"
    end
  end

  class Association < CouchRest::Model
    key_accessor :name, :type, :player
    view_by      :name
        
    def to_xml
      xml = ""
      xml << "<association id='#{id}' type='#{type}'>"
      xml << "<origin ref='#{name}' />"
      xml << "<player ref='#{player}'/>"
      xml << "</association>"
      xml
    end
    
    def to_html
      "<dl class='association'><dt>#{Helper.to_link(type)}</dt><dd class='player'>#{Helper.to_link(player)}</dd></dl>"
    end
  end

end


__END__
#######

def show obj
  puts obj.inspect
  puts
end


class Page < TopicMap::Topic
  key_accessor :content, :name
  view_by :name
end

tm = TopicMap::TopicMapHelper.new

params = {}
params[:name] = 'OleChristianRynning'
params[:content] = 'Lorem ipsum...'
oc = Page.new(params)
puts "oc"
show oc

oc.save

sd = Page.by_name( :key => 'nonexisting' )
puts "SD NULL" if sd.nil?
puts "SD EMPTY" if sd.empty?
show sd

puts "occ"
occ = Page.by_name(:key => 'OleChristianRynning')[0]
show occ

r = Page.new( :name => 'Rynning', :content => 'Familie')
r.save

f = Page.new( :name => 'Familienavn', :content => 'a' )
f.save 

tm.new_occurrence(:name => 'OleChristianRynning', :content => 'http://oc.rynning.no', :type => 'Hjemmeside')
tm.new_association(:name => 'OleChristianRynning', :type => 'Familienavn', :player => 'Rynning')

puts "occx"
occ = Page.by_name(:key => 'OleChristianRynning')[0]
show occ
show occ.occurrences

uo = Page.new( :name => 'Yo', :content => 'MAMA' )
uo.save

puts "yo"

top = Page.by_name( :key => 'Yo' )[0]
show top
puts "NAMEx: #{top.name} CONTENT: #{top.content}"