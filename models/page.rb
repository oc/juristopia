class Page < TopicMap::Topic
  
  TYPES = [:page, :association_type, :occurrence_type]
  
  unique_id    :name
  key_reader   :name
  key_accessor :content
  view_by      :name
  view_by      :content
  
  timestamps!
  
  def type=(type)
    self['type'] = TYPES.include?(type) ? type : :page
  end
  
  def type
    self['type'] ||= :page
  end
  
  class << self
    def create!(opts = {})
      if opts.has_key?(:name) or opts.has_key?('name')
        pages = Page.by_name(:key => opts[:name])
        pages.each {|p| p.destroy }
      end            
      page = Page.new(opts) 
      page if page.save
    end
    
    def query(q)
      []
    end
  end  
end


