module Manageo::Company
  def email(siren:)
    Manageo.get "email/v1/#{siren}/emailGenerique"
  end

  def contact(siren:)
    Manageo.get "marque/v1/#{siren}/contact"
  end

  def establishments(siren:)
    Manageo.get "marque/v1/#{siren}/etablissements"
  end

  def directors(siren:)
    Manageo.get "marque/v1/#{siren}/dirigeants"
  end

  def brands(siren:)
    Manageo.get "marque/v1/#{siren}/marques"
  end

  def solvability(siren:)
    Manageo.get "solvability/v1/#{siren}/solvabiliteEven"
  end

  def financial(siren:)
    Manageo.get "financial/v1/#{siren}"
  end

  def identity(siren:, nic:)
    Manageo.get "identity/v1/#{siren}/#{nic}"
  end

  def infos(siren:, nic: '')
    Manageo.get File.join("allinfos/v1/#{siren}", nic)
  end

  def search(term:, **args)
    Manageo.get "search/v1/companies?" + URI.encode_www_form(args.merge(term: term))
  end

  module_function :email, :establishments, :directors, :brands,
                  :solvability, :financial, :identity, :infos,
                  :search, :contact
end
