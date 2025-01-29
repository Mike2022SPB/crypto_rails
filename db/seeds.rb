crypto_list = [ 
  {title: "Bitcoin",     coin_symbol: "BTC" }, 
  {title: "Ethereum",    coin_symbol: "ETH"}, 
  {title: "Tether",      coin_symbol: "USDT"}, 
  {title: "Binancecoin", coin_symbol: "BNB"}, 
  {title: "Solana",      coin_symbol: "SOL"}, 
  {title: "Ripple",      coin_symbol: "XRP"}, 
  {title: "Usd-coin",    coin_symbol: "USDC"}, 
  {title: "Cardano",     coin_symbol: "ADA"}, 
  {title: "Dogecoin",    coin_symbol: "DOGE"}, 
  {title: "Tontoken",    coin_symbol: "TON"}
]

crypto_list.each do |crypto|
  sleep 1
  id = crypto[:title].downcase

  url = "https://api.coingecko.com/api/v3/coins/#{id}/market_chart?vs_currency=usd&days=91"

  response = HTTParty.get(url, headers: {
    "accept" => "application/json",
    "x-cg-demo-api-key" => ENV.fetch('COINGECKO_API_KEY')
  })

  if response.code == 200
    received_data_json = response.parsed_response
    currency = Currency.find_or_create_by!(title: crypto[:title], coin_symbol: crypto[:coin_symbol])

    last_7_prices = received_data_json["prices"].last(8)
    last_7_prices.each do |date_price|
      date = Time.at(date_price[0] / 1000).to_datetime
      value = date_price[1]

      puts "#{currency.inspect} #{date} #{value}"

      currency.prices.find_or_create_by!(date: date, value: value)
    end
  else
    puts "Error: Received response code #{response.code}"
  end
end
