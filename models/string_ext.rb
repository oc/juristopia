require 'RedCloth'
class String
  def to_html
    RedCloth.new(self).to_html
  end
 
  def auto_link
    if self =~ /(\[((https?|ftp):[^'">\s|]+)(\|([^|'"]+))?)\]/xi
      self.gsub($1, %Q{<a href="#{$2}">#{$5 || $1}</a>})
    end
  end
 
  def wiki_link
    self.gsub(/\s+([A-Z][a-z]+[A-Z][A-Za-z0-9]+)\s+/) do |page|
      unless Page.by_name(page).empty?
        %Q{<a class="existing_link" href="/#{page}">#{page}</a>} 
      else
        %Q{<a class="nonexisting_link" href="/#{page}">#{page}</a>}
      end
    end
  end
  
  def titleize
    self.gsub(/([A-Z]+)([A-Z][a-z])/,'\1 \2').gsub(/([a-z\d])([A-Z])/,'\1 \2')
  end
 
  def without_ext
    self.sub(File.extname(self), '')
  end
end