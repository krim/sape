require 'spec_helper'

describe SapeLink, :type => :model do
  before do
    SapeLink.delete_all
  end

  context '#host' do
    it 'should return host without path' do
      link = SapeLink.create(
        page: '/test',
        anchor: 'You must see',
        url: 'http://kremlin.ru/rss',
        host: 'kremlin.ru',
        raw_link: '',
        link_type: "simple"
        )
      expect(link.host).to eq('kremlin.ru')
    end
  end
end