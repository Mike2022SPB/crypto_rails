class Currency < ApplicationRecord
  has_many :portfolio_currencies
  has_many :portfolios, through: :portfolio_currencies
  has_many :prices

  def actual_price 
    price_object = prices.max_by { |price| price.date }
    price_object&.value
  end
end
