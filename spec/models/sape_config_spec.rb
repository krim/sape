require 'spec_helper'

describe SapeConfig, :type => :model do
  before do
    SapeConfig.delete_all
  end

  context '#start_code' do
    it 'should return code' do
      SapeConfig.create name: 'start', value: '<!--start-code-->'
      expect(SapeConfig.start_code).to eq('<!--start-code-->')
    end
  end

  context '#stop_code' do
    it 'should return code' do
      SapeConfig.create name: 'end', value: '<!--stop-code-->'
      expect(SapeConfig.stop_code).to eq('<!--stop-code-->')
    end
  end

  context '#bot_ips' do
    it 'should return bot ips array' do
      SapeConfig.create name: 'ip', value: '127.0.0.1'
      expect(SapeConfig.bot_ips).to eq(['127.0.0.1'])
    end
  end
end