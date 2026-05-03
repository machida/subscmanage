class NextPaymentUpdateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    subscription_services = SubscriptionService.payment_for_that_day(Date.current - 1)
    subscription_services.find_each do |service|
      unless service.update_next_payment
        Rails.logger.error "next_payment_upate_job failed with #{service}."
        next
      end
    end
  end
end
