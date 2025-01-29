class PortfolioController < ApplicationController
  def index
    @currencies = Currency.all
    @user_currencies = current_user.personal_portfolio
  end

  def add_token_to_portfolio
    if params_and_data_сhecking(token_params)
      redirect_to portfolio_index_path, notice: "Добавлен"
    else
      redirect_to portfolio_index_path, notice: "Не все поля заполнены"
    end
  end

  def update_token_amount
    portfolio_currency = PortfolioCurrency.find_by(id: token_params[:id])

    if portfolio_currency.update(amount: token_params[:amount])
      redirect_to portfolio_index_path, notice: "Amount updated successfully!"
    else
      redirect_to portfolio_index_path, notice: "Failed to update amount!"
    end
  end

  def remove_token
    portfolio_currency = PortfolioCurrency.find_by(id: token_params[:id])

    if portfolio_currency.destroy
      redirect_to portfolio_index_path, notice: "Token removed"
    else
      redirect_to portfolio_index_path, notice: "Failed to remove token!"
    end
  end

  def show_currency_prices
    @currency = Currency.find_by(currency_params)
    @currency_prices = @currency.prices.order(date: :desc)
  end

  private

  def params_and_data_сhecking(token_params)
    if token_params["title"].present? && token_params["amount"].present?
      currency = Currency.find_by(title: token_params[:title])
      if currency.present?
        current_user.portfolio.add_tokens(currency, token_params[:amount])
        true
      else
        false
      end
    elsif token_params["coin_symbol"].present? && token_params["amount"].present?
      currency = Currency.find_by(coin_symbol: token_params[:coin_symbol])
      if currency.present?
        current_user.portfolio.add_tokens(currency, token_params[:amount])
        true
      else
        false
      end
    else
      false
    end
  end

  def currency_params
    params.permit(:id)
  end

  def token_params
    params.permit(:id, :title, :coin_symbol, :amount)
  end
end
