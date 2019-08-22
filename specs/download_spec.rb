require 'rspec'
require 'helpers/download'

describe Downloads::Asset do
  let(:asset) do
    Downloads::Asset.new({
      'name' => ' svalinn-0.10.0.linux-amd64.tar.gz',
    })
  end

  let(:beta) do
    Downloads::Asset.new({
      'name' => 'caduceus-0.1.5.darwin-amd64.tar.gz',
    })
  end

  describe '#os' do
    it 'extracts the operating system name' do
      expect(asset.os).to eql('linux')
      expect(beta.os).to eql('darwin')
    end
  end

  describe '#arch' do
    it 'extracts the architecture' do
      expect(asset.arch).to eql('amd64')
      expect(beta.arch).to eql('amd64')
    end
  end
end
