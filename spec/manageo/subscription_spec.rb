require 'spec_helper'

describe Manageo::Subscription do
  subject { Manageo::Subscription }

  before do
    allow(Manageo).to receive(:connection).and_return(
      Excon.new( Manageo.url, mock: true )
    )
  end

  after do
    Excon.stubs.clear
  end

  it { should be_a Module }

  context 'infos' do
    it 'should call the info endpoint' do
      Excon.stub({path: "/mcompany-api/subscription/v1/infos"}, {body: "{}", status: 200})
      subject.infos
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.infos ).to be_a OpenStruct
    end
  end

  context 'consumption' do
    it 'should call the consumption endpoint' do
      Excon.stub({path: "/mcompany-api/subscription/v1/consommationperiod"}, {body: "{}", status: 200})
      subject.consumption
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.consumption ).to be_a OpenStruct
    end
  end

end
