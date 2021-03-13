# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    organization { 'Reported' }
    name { 'Rite Aid Pharmacy #5462' }
    addr1 { '300 North Canon Drive' }
    addr2 { 'Beverly Hills, CA 90210' }
    link { 'https://www.riteaid.com/pharmacy/covid-qualifier' }
  end
end
