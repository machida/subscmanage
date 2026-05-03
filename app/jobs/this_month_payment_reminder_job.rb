class ThisMonthPaymentReminderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.find_each do |user|
      begin
        PaymentMailer.with(user: user).this_month_payment.deliver_now
      rescue Net::SMTPError => e
        Rails.logger.error "this_month_payment_remainder_job failed with #{e.message}"
        next
      end
    end
  end
end
