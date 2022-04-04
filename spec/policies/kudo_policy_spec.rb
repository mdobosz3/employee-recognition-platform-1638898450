# frozen_string_literal: true

require 'rails_helper'

describe KudoPolicy do
  context 'when employee want to edit kudo' do
    let!(:employee) { create(:employee) }
    let!(:kudo) { create(:kudo) }

    permissions :update?, :edit?, :destroy? do
      it 'denies access if kudo is published more than 5 minutes ago' do
        travel 6.minutes
        expect(described_class).not_to permit(employee, kudo)
      end

      it 'granst access if kudo is published less than 5 minutes ago' do
        expect(described_class).to permit(employee, kudo)
      end
    end
  end
end
