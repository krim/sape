require 'spec_helper'

describe 'sape:fetch' do
  include_context 'rake'

  its(:prerequisites) { should include('environment') }

  describe 'Without config file' do

    it 'should fails with message' do
      expect { subject.invoke }
        .to raise_exception(RuntimeError, 'Config file not found (config/sape.yml)')
    end

  end

  describe 'With config file' do
    let(:config)   { YAML.load(File.open(Rails.root.join('spec', 'fixtures', 'sape.yml'))) }
    let(:response) { File.open(Rails.root.join('spec', 'fixtures', 'response.json')) }
    let(:url)      { 'http://db.sape.ru/abcdefg/kremlin.ru/UTF-8.xml' }

    before do
      YAML.stub(:load_file).with('config/sape.yml').and_return(config)
      FakeWeb.register_uri(:any, url, body: response)
      SapeConfig.any_instance.stub(:delete_all).and_return(:true)
      SapeLink.any_instance.stub(:delete_all).and_return(:true)
    end

    it 'should fetch xml file' do
      subject.invoke
      FakeWeb.should have_requested(:get, url)
    end

    it 'should fails if could not get file' do
      FakeWeb.register_uri(:any, url, status: 404)
      expect { subject.invoke }
        .to raise_exception(RuntimeError, 'Could not receive data')
    end

    it 'should add data' do
      subject.invoke
      SapeConfig.count.should eq 7
      SapeLink.count.should   eq 1
    end
  end

end