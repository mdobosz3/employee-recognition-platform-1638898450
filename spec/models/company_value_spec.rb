# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompanyValue, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  # it { shoulda validate_presence_of(:title) }
end
