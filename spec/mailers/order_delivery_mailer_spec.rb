# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderDeliveryMailer, type: :mailer do
  describe 'Order delivery confirmation' do
    let!(:reward1) { create(:reward, delivery_method: 'post') }
    let!(:order1) { create(:order, reward: reward1, reward_snapshot: reward1) }
    let!(:address) { create(:address, order: order1) }
    let(:mail1) { described_class.with(order: order1).delivery_by_post_email.deliver_now }

    let!(:reward2) { create(:reward, delivery_method: 'online') }
    let!(:order2) { create(:order, reward: reward2, reward_snapshot: reward2) }
    let!(:reward_code) { create(:reward_code, reward: reward2, order: order2) }
    let(:mail2) { described_class.with(order: order2).delivery_email.deliver_now }

    # delivery by post
    it 'checking the headers post email' do
      order1.address = address
      expect(mail1.subject).to have_content 'Your order has been delivered'
      expect(mail1.to).to have_content order1.employee.email
      expect(mail1.from).to have_content 'doboszmichal33@gmail.com'
    end

    it 'checking the body post email' do
      expect(mail1.body).to have_content order1.employee.first_name
      expect(mail1.body).to have_content order1.reward_snapshot.title
      expect(mail1.body).to have_content order1.address.street
      expect(mail1.body).to have_content order1.address.postcode
      expect(mail1.body).to have_content order1.address.city
    end

    # delivery by email
    it 'checking the headers' do
      order2.reward_code = reward_code
      expect(mail2.subject).to have_content 'Your order has been delivered'
      expect(mail2.to).to have_content order2.employee.email
      expect(mail2.from).to have_content 'doboszmichal33@gmail.com'
    end

    it 'checking the body' do
      expect(mail2.body).to have_content order2.employee.first_name
      expect(mail2.body).to have_content order2.reward_snapshot.title
      expect(mail2.body).to have_content order2.reward_code.code
    end
  end
end
