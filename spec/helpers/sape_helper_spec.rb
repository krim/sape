require 'spec_helper'
require 'app/helpers/sape_helper'

describe SapeHelper do
  describe '#sape_links' do

    subject { helper.sape_links }

    before do
      helper.request.path = '/'
      SapeLink.stub(:where).with(page: '/')
        .and_return([
          mock_model(SapeLink,
                     page:   '/',
                     url:    'http://kremlin.ru',
                     anchor: 'See some stuff',
                     text:   'Visit Kremlin',
                     host:   'kremlin.ru'
          )])
    end

    it { should include('kremlin.ru') }
    it { should include('See some stuff') }
    it { should include('Visit Kremlin') }

    describe 'recognized as bot' do
      before do
        helper.request.remote_addr = '127.0.0.1'
        SapeConfig.stub(:bot_ips).and_return(['127.0.0.1'])
        SapeConfig.stub(:start_code).and_return('<!--start-->')
        SapeConfig.stub(:stop_code).and_return('<!--end-->')
      end

      it { should include('<!--start-->') }
      it { should include('<!--end-->') }

    end
  end
end