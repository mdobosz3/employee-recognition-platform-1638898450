# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderDeliveryMailer, type: :mailer do
  describe "Order delivery confirmation" do
    let(:order) { create(:order) }
    let(:mail) { described_class.with(order: order).delivery_email.deliver_now }

    it "checking the headers" do
      expect(mail.subject).to have_content 'Your order has been delivered'
      expect(mail.to).to have_content order.employee.email
      expect(mail.from).to have_content 'doboszmichal33@gmail.com'
    end

    it "checking the body" do
      expect(mail.body).to have_content order.reward_snapshot.title
    end
  end
end
