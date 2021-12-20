# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /home' do
    it 'returns http success' do
      root 'pages#home'
      expect(response).to have_http_status(:success)
    end
  end
end
