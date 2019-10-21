# frozen_string_literal: true

RSpec.describe Law::LawBase, type: :law do
  include_context "with an example law"

  it { is_expected.to inherit_from Spicerack::RootObject }

  it { is_expected.to include_module Law::Laws::Regulations }
end
