# 開発用ユーザー（development環境のみ）
if Rails.env.development?
  admin = User.find_or_initialize_by(email: "admin@example.com")
  if admin.new_record?
    admin.password = "password"
    admin.password_confirmation = "password"
    admin.email_confirmation = "admin@example.com"
    admin.role = :admin
    admin.save!
    puts "Created admin user: #{admin.email}"
  end

  user = User.find_or_initialize_by(email: "user@example.com")
  if user.new_record?
    user.password = "password"
    user.password_confirmation = "password"
    user.email_confirmation = "user@example.com"
    user.save!
    [
      { name: "Netflix", next_payment: Date.current.next_month, payment_interval: 1, payment_unit: :month, price: 1590, monetary_unit: :JPY },
      { name: "Spotify Premium", next_payment: Date.current.next_month, payment_interval: 1, payment_unit: :month, price: 980, monetary_unit: :JPY },
      { name: "iCloud+ 200GB", next_payment: Date.current.next_month, payment_interval: 1, payment_unit: :month, price: 450, monetary_unit: :JPY }
    ].each do |attrs|
      user.subscription_services.create!(attrs)
    end
    puts "Created general user: #{user.email} with #{user.subscription_services.count} services"
  end
  
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
  
  puts "Seeded Exchanges."
end

service_presets = [
  { name: "Netflix", payment_interval: 1, payment_unit: :month, price: 1590, monetary_unit: :JPY },
  { name: "Amazon Prime", payment_interval: 1, payment_unit: :month, price: 600, monetary_unit: :JPY },
  { name: "Amazon Prime 年額", payment_interval: 1, payment_unit: :year, price: 5900, monetary_unit: :JPY },
  { name: "Disney+", payment_interval: 1, payment_unit: :month, price: 1140, monetary_unit: :JPY },
  { name: "Disney+ 年額", payment_interval: 1, payment_unit: :year, price: 11400, monetary_unit: :JPY },
  { name: "Hulu", payment_interval: 1, payment_unit: :month, price: 1026, monetary_unit: :JPY },
  { name: "U-NEXT", payment_interval: 1, payment_unit: :month, price: 2189, monetary_unit: :JPY },
  { name: "ABEMAプレミアム", payment_interval: 1, payment_unit: :month, price: 1080, monetary_unit: :JPY },
  { name: "dアニメストア", payment_interval: 1, payment_unit: :month, price: 550, monetary_unit: :JPY },
  { name: "DAZN", payment_interval: 1, payment_unit: :month, price: 4200, monetary_unit: :JPY },
  { name: "Leminoプレミアム", payment_interval: 1, payment_unit: :month, price: 990, monetary_unit: :JPY },
  { name: "NHKオンデマンド", payment_interval: 1, payment_unit: :month, price: 990, monetary_unit: :JPY },
  { name: "YouTube Premium", payment_interval: 1, payment_unit: :month, price: 1280, monetary_unit: :JPY },
  { name: "YouTube Music Premium", payment_interval: 1, payment_unit: :month, price: 1080, monetary_unit: :JPY },
  { name: "Spotify Premium", payment_interval: 1, payment_unit: :month, price: 980, monetary_unit: :JPY },
  { name: "Apple Music", payment_interval: 1, payment_unit: :month, price: 1080, monetary_unit: :JPY },
  { name: "Amazon Music Unlimited", payment_interval: 1, payment_unit: :month, price: 1080, monetary_unit: :JPY },
  { name: "LINE MUSIC", payment_interval: 1, payment_unit: :month, price: 1080, monetary_unit: :JPY },
  { name: "AWA", payment_interval: 1, payment_unit: :month, price: 980, monetary_unit: :JPY },
  { name: "Audible", payment_interval: 1, payment_unit: :month, price: 1500, monetary_unit: :JPY },
  { name: "Kindle Unlimited", payment_interval: 1, payment_unit: :month, price: 980, monetary_unit: :JPY },
  { name: "楽天マガジン", payment_interval: 1, payment_unit: :month, price: 572, monetary_unit: :JPY },
  { name: "楽天マガジン 年額", payment_interval: 1, payment_unit: :year, price: 5500, monetary_unit: :JPY },
  { name: "dマガジン", payment_interval: 1, payment_unit: :month, price: 580, monetary_unit: :JPY },
  { name: "Nintendo Switch Online", payment_interval: 1, payment_unit: :year, price: 2400, monetary_unit: :JPY },
  { name: "Nintendo Switch Online + 追加パック", payment_interval: 1, payment_unit: :year, price: 4900, monetary_unit: :JPY },
  { name: "PlayStation Plus Essential", payment_interval: 1, payment_unit: :month, price: 850, monetary_unit: :JPY },
  { name: "Xbox Game Pass Core", payment_interval: 1, payment_unit: :month, price: 842, monetary_unit: :JPY },
  { name: "Xbox Game Pass Ultimate", payment_interval: 1, payment_unit: :month, price: 1450, monetary_unit: :JPY },
  { name: "Adobe Creative Cloud コンプリートプラン", payment_interval: 1, payment_unit: :month, price: 7780, monetary_unit: :JPY },
  { name: "Adobe Photoshop", payment_interval: 1, payment_unit: :month, price: 3280, monetary_unit: :JPY },
  { name: "Canva Pro", payment_interval: 1, payment_unit: :month, price: 1500, monetary_unit: :JPY },
  { name: "Canva Pro 年額", payment_interval: 1, payment_unit: :year, price: 11800, monetary_unit: :JPY },
  { name: "Figma Professional", payment_interval: 1, payment_unit: :month, price: 15, monetary_unit: :USD },
  { name: "Notion Plus", payment_interval: 1, payment_unit: :month, price: 10, monetary_unit: :USD },
  { name: "Evernote Personal", payment_interval: 1, payment_unit: :month, price: 1100, monetary_unit: :JPY },
  { name: "1Password", payment_interval: 1, payment_unit: :month, price: 3, monetary_unit: :USD },
  { name: "Dropbox Plus", payment_interval: 1, payment_unit: :month, price: 1500, monetary_unit: :JPY },
  { name: "Dropbox Professional", payment_interval: 1, payment_unit: :month, price: 2400, monetary_unit: :JPY },
  { name: "Google One 100GB", payment_interval: 1, payment_unit: :month, price: 250, monetary_unit: :JPY },
  { name: "Google One 2TB", payment_interval: 1, payment_unit: :month, price: 1300, monetary_unit: :JPY },
  { name: "iCloud+ 50GB", payment_interval: 1, payment_unit: :month, price: 150, monetary_unit: :JPY },
  { name: "iCloud+ 200GB", payment_interval: 1, payment_unit: :month, price: 450, monetary_unit: :JPY },
  { name: "iCloud+ 2TB", payment_interval: 1, payment_unit: :month, price: 1500, monetary_unit: :JPY },
  { name: "Microsoft 365 Personal", payment_interval: 1, payment_unit: :month, price: 1490, monetary_unit: :JPY },
  { name: "Microsoft 365 Personal 年額", payment_interval: 1, payment_unit: :year, price: 14900, monetary_unit: :JPY },
  { name: "GitHub Copilot", payment_interval: 1, payment_unit: :month, price: 10, monetary_unit: :USD },
  { name: "ChatGPT Plus", payment_interval: 1, payment_unit: :month, price: 20, monetary_unit: :USD },
  { name: "Claude Pro", payment_interval: 1, payment_unit: :month, price: 20, monetary_unit: :USD },
  { name: "Perplexity Pro", payment_interval: 1, payment_unit: :month, price: 20, monetary_unit: :USD },
  { name: "Midjourney Basic", payment_interval: 1, payment_unit: :month, price: 10, monetary_unit: :USD },
  { name: "Midjourney Standard", payment_interval: 1, payment_unit: :month, price: 30, monetary_unit: :USD },
  { name: "Cursor Pro", payment_interval: 1, payment_unit: :month, price: 20, monetary_unit: :USD },
  { name: "X Premium", payment_interval: 1, payment_unit: :month, price: 980, monetary_unit: :JPY },
  { name: "LinkedIn Premium", payment_interval: 1, payment_unit: :month, price: 2980, monetary_unit: :JPY },
  { name: "食べログプレミアム", payment_interval: 1, payment_unit: :month, price: 330, monetary_unit: :JPY },
  { name: "ピッコマWEB 待てば0円以外課金", payment_interval: 1, payment_unit: :month, price: 500, monetary_unit: :JPY }
]

service_presets.each do |attributes|
  Admin::ServicePreset.find_or_create_by!(name: attributes[:name]) do |preset|
    preset.payment_interval = attributes[:payment_interval]
    preset.payment_unit = attributes[:payment_unit]
    preset.price = attributes[:price]
    preset.monetary_unit = attributes[:monetary_unit]
  end
end

puts "Seeded #{Admin::ServicePreset.count} service presets"
