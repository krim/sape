require 'spec_helper'

describe SapeConfig, :type => :model do
  before do
    SapeConfig.delete_all
  end

  context '#check_code' do
    it 'should return check code' do
      SapeConfig.create name: 'sape_new_url', value: '<!--check_code-->'
      expect(SapeConfig.check_code).to eq('<!--check_code-->')
    end
  end

  context '#delimiter' do
    it 'should return delimiter' do
      SapeConfig.create name: 'sape_delimiter', value: ', '
      expect(SapeConfig.delimiter).to eq(', ')
    end
  end

  context '#bot_ips' do
    it 'should return bot ips array' do
      SapeConfig.create name: 'ip', value: '127.0.0.1'
      expect(SapeConfig.bot_ips).to eq(['127.0.0.1'])
    end
  end
end