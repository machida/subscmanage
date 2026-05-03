if Rails.env.development?
  exchanges = [
    { base_currency: "JPY", base_date: "2026-01-09", data: { "rates": { "AUD": 0.0095, "BRL": 0.03418, "CAD": 0.00881, "CHF": 0.00508, "CNY": 0.04429, "CZK": 0.13261, "DKK": 0.04072, "EUR": 0.00545, "GBP": 0.00473, "HKD": 0.04946, "HUF": 2.1035, "IDR": 106.95, "ILS": 0.02002, "INR": 0.57231, "ISK": 0.80318, "KRW": 9.2608, "MXN": 0.11436, "MYR": 0.02584, "NOK": 0.06417, "NZD": 0.01108, "PHP": 0.37563, "PLN": 0.02296, "RON": 0.02774, "SEK": 0.05857, "SGD": 0.00816, "THB": 0.19961, "TRY": 0.27345, "USD": 0.00634, "ZAR": 0.10515 } } },
    { base_currency: "USD", base_date: "2026-01-09", data: { "rates": { "AUD": 1.4981, "BRL": 5.3885, "CAD": 1.3883, "CHF": 0.80003, "CNY": 6.9823, "CZK": 20.904, "DKK": 6.4185, "EUR": 0.85896, "GBP": 0.74532, "HKD": 7.7962, "HUF": 331.58, "IDR": 16860, "ILS": 3.1562, "INR": 90.22, "ISK": 126.61, "JPY": 157.64, "KRW": 1459.84, "MXN": 18.0278, "MYR": 4.0735, "NOK": 10.1155, "NZD": 1.747, "PHP": 59.212, "PLN": 3.6195, "RON": 4.3723, "SEK": 9.2321, "SGD": 1.2871, "THB": 31.465, "TRY": 43.106, "ZAR": 16.575 } } }
  ]

  exchanges.each do |attributes|
    Exchange.find_or_create_by!(base_currency: attributes[:base_currency]) do |exchange|
      exchange.base_date = attributes[:base_date]
      exchange.data = attributes[:data].to_json
    end
  end
end
