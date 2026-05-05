class Exchange < ApplicationRecord
  SUPPORTED_CURRENCIES = [ :JPY, :USD ]

  validates :base_currency, inclusion: { in: SUPPORTED_CURRENCIES.map(&:to_s) }

  scope :latest_exchange, ->(currency) { where(base_currency: currency).order(created_at: :desc).first }
end
