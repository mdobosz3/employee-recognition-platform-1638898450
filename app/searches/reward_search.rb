# frozen_string_literal: true

class RewardSearch < Searchlight::Search
    def base_query
      Reward.includes(:categories, :category_rewards).all
    end
  
    def search_category_id
      query.joins(:categories).where(categories: { id: category_id }).includes(:categories, :category_rewards)
    end
  end
