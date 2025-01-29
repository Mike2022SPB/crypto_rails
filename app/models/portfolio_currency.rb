class PortfolioCurrency < ApplicationRecord
  belongs_to :portfolio
  belongs_to :currency

  after_commit :calculate_portfolio_value

  def total_cost
    currency.actual_price * amount
  end

  def calculate_portfolio_value
    portfolio.calculate_value
  end
end
