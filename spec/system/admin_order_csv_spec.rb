# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Order check', type: :system do
  context 'when the admin want export csv file with orders' do
    let(:admin_user) { create(:admin_user) }
    let!(:order1) { create(:order) }
    let!(:order2) { create(:order) }

    it 'export csv with orders' do
      sign_in admin_user

      visit admin_root_path
      click_link 'Orders'
      click_link 'Download CSV list'

      csv = CSV.new(page.body).read
      headers = '["Employee Email", "Title", "Description", "Price", "Purchase time", "Status", "Street", "Postcode", "City"]'
      row1 = "[\"  #{order1.employee.email}\", \"#{order1.reward_snapshot.title}\", \"#{order1.reward_snapshot.description}\", " \
                "\"#{order1.reward_snapshot.price}\", \"#{order1.created_at}\", \"#{order1.status}\", \"\", \"\", \"\"]"
      row2 = "[\"  #{order2.employee.email}\", \"#{order2.reward_snapshot.title}\", \"#{order2.reward_snapshot.description}\", " \
                "\"#{order2.reward_snapshot.price}\", \"#{order2.created_at}\", \"#{order2.status}\", \"\", \"\", \"\"]"
      expect(csv).to have_content headers
      expect(csv).to have_content row1
      expect(csv).to have_content row2
    end
  end
end
