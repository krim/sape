require 'spec_helper'

describe SapeConfig do
  before do
    SapeConfig.delete_all
  end

  context '#start_code' do
    it 'should return code' do
      SapeConfig.create name: 'start', value: '<!--start-code-->'
      SapeConfig.start_code.should eq('<!--start-code-->')
    end
  end

  context '#stop_code' do
    it 'should return code' do
      SapeConfig.create name: 'end', value: '<!--stop-code-->'
      SapeConfig.stop_code.should eq('<!--stop-code-->')
    end
  end

  context '#bot_ips' do
    it 'should return bot ips array' do
      SapeConfig.create name: 'ip', value: '127.0.0.1'
      SapeConfig.bot_ips.should eq(['127.0.0.1'])
    end
  end
end