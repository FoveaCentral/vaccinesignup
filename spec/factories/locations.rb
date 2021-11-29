# Copyright the @vaccinesignup contributors.
# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    name { 'Rite Aid Pharmacy #5462' }
    addr1 { '300 North Canon Drive' }
    addr2 { 'Beverly Hills, CA 90210' }
    la_id { '5462' }
    link { 'https://www.riteaid.com/pharmacy/covid-qualifier' }

    trait :with_bad_name do
      name { 'Rite Aid Pharmacy' }
    end
    trait '90044' do
      name { 'Crenshaw Clinic' }
      addr1 { '1261 W 79th Street' }
      addr2 { 'Los Angeles, CA 90044' }
      link { 'https://carbonhealth.com/covid-19-vaccines' }
    end
  end
end
