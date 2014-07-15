require 'spec_helper'

describe SapeLink do
  before do
    SapeLink.delete_all
  end

  context '#host' do
    it 'should return host without path' do
      link = SapeLink.create(
        page: '/test',
        anchor: 'You must see',
        text: 'very interesting thing',
        url: 'http://kremlin.ru/rss',
        link_type: "simple"
        )
      link.host.should eq('kremlin.ru')
    end
  end
end