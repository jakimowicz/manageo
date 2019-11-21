require 'spec_helper'

describe Manageo do
  subject { Manageo }

  it { should be_a Module }

  context 'url' do
    context 'when the MANAGEO_URL ENV variable is not set' do
      before do
        allow(ENV).to receive(:[]).with('MANAGEO_URL').and_return(nil)
        Manageo.url = nil
      end

      its(:default_url) { should == 'https://api.manageo.com' }
      its(:env_url)     { should be_nil }
      its(:url)         { should == 'https://api.manageo.com' }
    end

    context 'when the MANAGEO_URL ENV variable is set' do
      before do
        allow(ENV).to receive(:[]).with('MANAGEO_URL').and_return('https://foo.bar')
        Manageo.url = nil
      end

      its(:default_url) { should == 'https://api.manageo.com' }
      its(:env_url)     { should == 'https://foo.bar' }
      its(:url)         { should == 'https://foo.bar' }
    end
  end

  context 'key' do
    context 'when the MANAGEO_KEY ENV variable is not set' do
      before do
        allow(ENV).to receive(:[]).with('MANAGEO_KEY').and_return(nil)
        Manageo.key = nil
      end

      its(:env_key) { should be_nil }
      its(:key)     { should be_nil }
    end

    context 'when the MANAGEO_KEY ENV variable is set' do
      before do
        allow(ENV).to receive(:[]).with('MANAGEO_KEY').and_return('XYZ12345')
        Manageo.key = nil
      end

      its(:env_key) { should == 'XYZ12345' }
      its(:key)     { should == 'XYZ12345' }
    end
  end

  context 'connection' do
    before do
      allow(ENV).to receive(:[]).with('MANAGEO_URL').and_return(nil)
      allow(ENV).to receive(:[]).with('MANAGEO_KEY').and_return('XYZ12345')
      allow(ENV).to receive(:[]).with('no_proxy').and_return(nil)
      allow(ENV).to receive(:[]).with('NO_PROXY').and_return(nil)
    end

    its(:connection) { should be_a Excon::Connection }
  end

  context 'parse_response' do
    let(:response) { Object.new }

    context 'when response is an array' do
      before do
        allow(response).to receive(:body).and_return('[{"a":42},{"a":55}]')
      end

      it 'should returns an array' do
        expect( subject.parse_response(response) ).to be_a Array
      end

      it 'should have OpenStruct items' do
        expect( subject.parse_response(response)[0] ).to be_a OpenStruct
        expect( subject.parse_response(response)[1] ).to be_a OpenStruct
      end

      it 'should have an OpenStruct item with the right keys' do
        expect( subject.parse_response(response)[0] ).to respond_to :a
        expect( subject.parse_response(response)[1] ).to respond_to :a
      end

      it 'should have an OpenStruct item with the right values' do
        expect( subject.parse_response(response)[0].a ).to be == 42
        expect( subject.parse_response(response)[1].a ).to be == 55
      end
    end

    context 'when response is a hash' do
      context 'with one single element' do
        before do
          allow(response).to receive(:body).and_return('{"a":42}')
        end

        it 'should returns the only value' do
          expect( subject.parse_response(response) ).to be_a Integer
          expect( subject.parse_response(response) ).to be == 42
        end
      end

      context 'with multiple elements' do
        before do
          allow(response).to receive(:body).and_return('{"a":42,"b":55}')
        end

        it 'should returns an OpenStruct' do
          expect( subject.parse_response(response) ).to be_a OpenStruct
        end

        it 'should responds to parsed keys' do
          expect( subject.parse_response(response) ).to respond_to :a
          expect( subject.parse_response(response) ).to respond_to :b
        end

        it 'should have an OpenStruct item with the right values' do
          expect( subject.parse_response(response).a ).to be == 42
          expect( subject.parse_response(response).b ).to be == 55
        end
      end
    end
  end

end
