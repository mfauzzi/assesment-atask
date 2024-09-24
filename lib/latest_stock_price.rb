# lib/latest_stock_price.rb
require 'net/http'
require 'json'

class LatestStockPrice
    API_HOST = 'https://latest-stock-price.p.rapidapi.com'

    def self.price(stock_ticker)
        response = fetch_data("/price/#{stock_ticker}")
        JSON.parse(response.body)
    end

    def self.prices(stock_tickers)
        response = fetch_data("/prices?tickers=#{stock_tickers.join(',')}")
        JSON.parse(response.body)
    end

    def self.price_all
        response = fetch_data("/price_all")
        JSON.parse(response.body)
    end

    private

    def self.fetch_data(endpoint)
        url = URI("#{API_HOST}#{endpoint}")
        Net::HTTP.get(url)
    end
end
