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
    let(:url)      { 'http://dispenser-01.sape.ru/code.php?user=082b3e62a664f746cc959643a7864d43&host=ballroom.ru&charset=utf-8' }

    before do
      allow(YAML).to receive(:load_file).with('config/sape.yml').and_return(config)
      FakeWeb.register_uri(:any, url, body: response)
      allow_any_instance_of(SapeConfig).to receive(:delete_all).and_return(:true)
      allow_any_instance_of(SapeLink).to receive(:delete_all).and_return(:true)
    end

    it 'should fetch xml file' do
      subject.invoke
      expect(FakeWeb).to have_requested(:get, url)
    end

    it 'should fails if could not get file' do
      FakeWeb.register_uri(:any, url, status: 404)
      expect { subject.invoke }
        .to raise_exception(RuntimeError, 'Could not receive data')
    end

    it 'should add data' do
      subject.invoke
      expect(SapeConfig.count).to eq 7
      expect(SapeLink.count).to   eq 1
    end
  end

end