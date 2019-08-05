# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe User, type: :model do
    context 'relations' do
      it { is_expected.to have_many(:notes) }
    end

    context 'validations' do
      it { is_expected.to validate_presence_of(:email) }
    end
  end
end
