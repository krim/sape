class SapeLink < ActiveRecord::Base
  def host
    link = Domainatrix.parse(url)
    link.host
  end
end