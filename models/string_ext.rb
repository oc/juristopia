require 'RedCloth'
class String
  def to_html
    RedCloth.new(self).to_html
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
  
end
