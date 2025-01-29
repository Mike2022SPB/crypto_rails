class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one   :portfolio
  has_many  :portfolio_currencies, through: :portfolio
  has_many  :currencies,           through: :portfolio_currencies

  after_create :create_portfolio

  def personal_portfolio
    portfolio.available_currencies
  end
  
  private

  def create_portfolio
    Portfolio.create_for_new_user(self)
  end
end
