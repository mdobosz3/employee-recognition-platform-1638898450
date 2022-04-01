require 'rails_helper'

describe KudoPolicy do
    subject { described_class }

    context "for a visitor" do
    let!(:employee) { create(:employee) }
    let!(:kudo) { create(:kudo) }
  
    permissions :update?, :edit?, :destroy? do
        
      it "denies access if kudo is published more than 5 minutes ago" do
        travel 6.minutes
            expect(subject).not_to permit(employee, kudo)
      end

      it "granst access if kudo is published less than 5 minutes ago" do
        expect(subject).to permit(employee, kudo)
      end

    end
  end
end
