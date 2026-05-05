class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subscription_services, dependent: :destroy

  enum :role, [ :general, :admin ]

  attr_accessor :email_confirmation

  validates :email_confirmation, presence: true, on: :create
  validate :email_matches_confirmation, on: :create

  def this_month_payment_services
    subscription_services.filter { |service| service.next_payment.month == Date.current.month }
  end

  private

  def email_matches_confirmation
    errors.add(:email_confirmation, :confirmation, message: "が一致しません") if email != email_confirmation
  end
end
