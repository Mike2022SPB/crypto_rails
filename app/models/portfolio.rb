class Portfolio < ApplicationRecord
  belongs_to :user
  has_many   :portfolio_currencies
  has_many   :currencies, through: :portfolio_currencies

  def self.create_for_new_user(user)
    create!(user: user)
  end

  def add_tokens(currency, amount)
    existing_currency = portfolio_currencies.find_by(currency: currency)
    if existing_currency.present?
      existing_currency.update(amount: existing_currency.amount + amount.to_d)
    else
      portfolio_currency = self.portfolio_currencies.build(currency: currency, amount: amount).save
    end
  end

  def available_currencies
    portfolio_currencies
  end

  def calculate_value
    portfolio_value = 0
    Portfolio.last.portfolio_currencies.each do |pcur|
      portfolio_value = portfolio_value + pcur.total_cost
    end
    update!(portfolio_value: portfolio_value)
  end
end
