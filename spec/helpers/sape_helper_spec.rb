require 'spec_helper'
require 'app/helpers/sape_helper'

describe SapeHelper, :type => :helper do
  describe '#sape_links' do

    subject { helper.sape_links }

    before do
      helper.request.path = '/'
      allow(SapeLink).to receive(:where).with(page: '/')
        .and_return([
          mock_model(SapeLink,
                     page:   '/',
                     url:    'http://kremlin.ru',
                     anchor: 'See some stuff',
                     text:   'Visit Kremlin',
                     host:   'kremlin.ru'
          )])
    end

    it { is_expected.to include('kremlin.ru') }
    it { is_expected.to include('See some stuff') }
    it { is_expected.to include('Visit Kremlin') }

    describe 'recognized as bot' do
      before do
        helper.request.remote_addr = '127.0.0.1'
        allow(SapeConfig).to receive(:bot_ips).and_return(['127.0.0.1'])
        allow(SapeConfig).to receive(:start_code).and_return('<!--start-->')
        allow(SapeConfig).to receive(:stop_code).and_return('<!--end-->')
      end

      it { is_expected.to include('<!--start-->') }
      it { is_expected.to include('<!--end-->') }

    end
  end
end