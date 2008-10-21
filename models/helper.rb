class Helper
  class << self    
    def parse(page)
      clean_for(page.name)
      page = occurrences_for(page)
      page = associations_for(page)
      page
    end
     
    def to_link(name)
      "<a href='#{BASE_IRI + '/' + name}'>#{name}</a>"
    end

    private
    def clean_for(name)
      occurrences = TopicMap::Occurrence.by_name(:key => name)
      occurrences.each {|o| o.destroy }
      associations = TopicMap::Association.by_name(:key => name)
      associations.each {|a| a.destroy }
    end

    def associations_for(page)
      page.content.scan(%r{(\[([\w&+=<>]+)\s+(\w+)\])}).each do |assoc,type,player|
      
        type = "SuperClass" if type == '>'
        type = "SubClass" if type == '<'
        type = "RelatedTerm" if type == '&'
        type = "IsA" if type == '='
        type = "InstanceOf" if type == '=='
        type = "ReferenceTo" if type == 'jf.'
        type = "ConferWith" if type == 'cf.'
      
        TopicMap::Association.new(:name => page.name, :player => player, :type => type).save
        page.content.gsub!(assoc, to_link(player))
      end
      page
    end
  
    def occurrences_for(page)
      page.content.scan(%r{(\((\w+)?\s+:\s+([^|]+)\))}).each do |occur,type,content|
      
        type = "Default" if type.nil? or type.empty?
      
        TopicMap::Occurrence.new(:name => page.name, :content => content, :type => type).save
        page.content.gsub!(occur, "")
      end
      page
    end    
  end  
end