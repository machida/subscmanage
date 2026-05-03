class SubscriptionService < ApplicationRecord
  belongs_to :user

  enum :payment_unit, [ :month, :year ], validate: true
  enum :monetary_unit, [ :JPY, :USD ], validate: true

  validates :name, presence: true
  validates :next_payment, comparison: { greater_than_or_equal_to: Date.current }
  validates :payment_interval, comparison: { greater_than: 0 }
  validates :price, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  scope :payment_for_that_day, ->(date) { where(next_payment: date) }

  def price_to_jpy
    if monetary_unit == "JPY"
      price
    elsif monetary_unit == "USD"
      (price * JSON.parse(Exchange.latest_exchange("USD").data)["rates"]["JPY"]).ceil
    end
  end

  def update_next_payment
    case payment_unit
    when "month"
      update({ next_payment: next_payment >> payment_interval })
    when "year"
      update({ next_payment: next_payment >> (payment_interval * 12) })
    end
  end
end
