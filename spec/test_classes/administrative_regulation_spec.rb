# frozen_string_literal: true

RSpec.describe AdministrativeRegulation, type: :regulation do
  it { is_expected.to inherit_from Law::RegulationBase }
  it { is_expected.to have_description "General restriction requiring Administrative access." }

  it { is_expected.to be_imposed_by AdminLaw }
end
