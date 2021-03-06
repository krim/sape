require 'spec_helper'
require 'app/helpers/sape_helper'

describe SapeHelper, :type => :helper do
  describe '#sape_links' do

    subject { helper.sape_links_block }

    before do
      helper.request.path = '/'
      helper.request.host = 'test.host'
      allow(SapeLink).to receive(:where).with(page: '/', link_type: "simple", site_host: "test.host")
        .and_return([
          mock_model(SapeLink,
                     page:   '/',
                     url:    'http://kremlin.ru',
                     anchor: 'See some stuff',
                     text:   'Visit Kremlin',
                     host:   'kremlin.ru',
                     raw_link: 'Visit Kremlin <a href="http://kremlin.ru">See some stuff</a>',
                     link_type: "simple",
                     site_host: "test.host"
          )])
    end

    it { is_expected.to include('kremlin.ru') }
    it { is_expected.to include('See some stuff') }
    it { is_expected.to include('Visit Kremlin') }

    describe 'recognized as bot' do
      before do
        helper.request.remote_addr = '127.0.0.1'
        allow(SapeConfig).to receive(:bot_ips).and_return(['127.0.0.1'])
        allow(SapeConfig).to receive(:check_code).and_return('<!--check_code-->')
      end

      it { is_expected.to include('<!--check_code-->') }

    end
  end
end