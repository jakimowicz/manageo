require 'spec_helper'
require 'ffaker'

describe Manageo::Company do
  subject { Manageo::Company }

  let(:siren) { FFaker::PhoneNumber.imei       }
  let(:nic)   { FFaker::PhoneNumber.imei[0..4] }
  let(:term)  { FFaker::Name.last_name         }

  before do
    allow(Manageo).to receive(:connection).and_return(
      Excon.new( Manageo.url, mock: true )
    )
  end

  after do
    Excon.stubs.clear
  end

  it { should be_a Module }

  context 'email' do
    it 'should call the email endpoint with given siren' do
      Excon.stub({path: "/mcompany-api/email/v1/#{siren}/emailGenerique"}, {body: "{}", status: 200})
      subject.email(siren: siren)
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.email(siren: siren) ).to be_a OpenStruct
    end
  end

  context 'contact' do
    it 'should call the contact endpoint with given siren' do
      Excon.stub({path: "/mcompany-api/marque/v1/#{siren}/contact"}, {body: "{}", status: 200})
      subject.contact(siren: siren)
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.contact(siren: siren) ).to be_a OpenStruct
    end
  end

  context 'establishments' do
    it 'should call the establishments endpoint with given siren' do
      Excon.stub({path: "/mcompany-api/marque/v1/#{siren}/etablissements"}, {body: "{}", status: 200})
      subject.establishments(siren: siren)
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.establishments(siren: siren) ).to be_a OpenStruct
    end
  end

  context 'directors' do
    it 'should call the directors endpoint with given siren' do
      Excon.stub({path: "/mcompany-api/marque/v1/#{siren}/dirigeants"}, {body: "{}", status: 200})
      subject.directors(siren: siren)
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.directors(siren: siren) ).to be_a OpenStruct
    end
  end

  context 'brands' do
    it 'should call the brands endpoint with given siren' do
      Excon.stub({path: "/mcompany-api/marque/v1/#{siren}/marques"}, {body: "{}", status: 200})
      subject.brands(siren: siren)
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.brands(siren: siren) ).to be_a OpenStruct
    end
  end

  context 'solvability' do
    it 'should call the solvability endpoint with given siren' do
      Excon.stub({path: "/mcompany-api/solvability/v1/#{siren}/solvabiliteEven"}, {body: "{}", status: 200})
      subject.solvability(siren: siren)
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.solvability(siren: siren) ).to be_a OpenStruct
    end
  end

  context 'financial' do
    it 'should call the financial endpoint with given siren' do
      Excon.stub({path: "/mcompany-api/financial/v1/#{siren}"}, {body: "{}", status: 200})
      subject.financial(siren: siren)
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.financial(siren: siren) ).to be_a OpenStruct
    end
  end

  context 'identity' do
    it 'should call the identity endpoint with given siren and nic' do
      Excon.stub({path: "/mcompany-api/identity/v1/#{siren}/#{nic}"}, {body: "{}", status: 200})
      subject.identity(siren: siren, nic: nic)
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.identity(siren: siren, nic: nic) ).to be_a OpenStruct
    end
  end

  context 'infos' do
    context 'when a nic is provided' do
      it 'should call the infos endpoint with given siren and' do
        Excon.stub({path: "/mcompany-api/allinfos/v1/#{siren}/#{nic}"}, {body: "{}", status: 200})
        subject.infos(siren: siren, nic: nic)
      end

      it 'should return an OpenStruct' do
        Excon.stub({}, {body: "{}", status: 200})
        expect( subject.infos(siren: siren, nic: nic) ).to be_a OpenStruct
      end
    end

    context 'when a nic is not provided' do
      it 'should call the infos endpoint with given siren and' do
        Excon.stub({path: "/mcompany-api/allinfos/v1/#{siren}/"}, {body: "{}", status: 200})
        subject.infos(siren: siren)
      end

      it 'should return an OpenStruct' do
        Excon.stub({}, {body: "{}", status: 200})
        expect( subject.infos(siren: siren) ).to be_a OpenStruct
      end
    end
  end

  context 'search' do
    it 'should call the search endpoint with given search term' do
      Excon.stub({path: "/mcompany-api/search/v1/companies?term=#{term}"}, {body: "{}", status: 200})
      subject.search(term: term)
    end

    it 'should call the search endpoint with extra arguments' do
      Excon.stub({path: "/mcompany-api/search/v1/companies?foo=bar&term=#{term}"}, {body: "{}", status: 200})
      subject.search(term: term, foo: 'bar')
    end

    it 'should return an OpenStruct' do
      Excon.stub({}, {body: "{}", status: 200})
      expect( subject.search(term: term) ).to be_a OpenStruct
    end
  end

end
