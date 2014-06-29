# == Schema Information
#
# Table name: purchases
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Purchase < ActiveRecord::Base
  attr_accessor :stripe_card_token

  def save_with_payment(email)
    if valid?
      begin
        # Railscast 288 shows how to do recuring payment
        # How read amount from DB
        charge = Stripe::Charge.create( amount: 5600,
                                        currency: "usd",
                                        card: stripe_card_token, # obtained with Stripe.js
                                        description: "Charge for #{email}" )

        save!
      rescue Stripe::CardError => e # Since it's a decline, Stripe::CardError will be caught
        body = e.json_body
        err = body[:error]
        logger.error "Status is: #{e.http_status}"
        logger.error "Type is: #{err[:type]}"
        logger.error "Code is: #{err[:code]}" # param is '' in this case
        logger.error "Param is: #{err[:param]}"
        logger.error "Message is: #{err[:message]}"
        errors.add :base, "There was a decline for the card."
        stripe_card_token = nil
        false
      rescue Stripe::InvalidRequestError => e # Invalid parameters were supplied to Stripe's API
        logger.error "Stripe error from charge: #{e.message}"
        errors.add :base, "There was a problem with your credit card."
        false
      rescue Stripe::AuthenticationError => e # Authentication with Stripe's API failed # (maybe you changed API keys recently)
        logger.error "Message is: #{err[:message]}"
        errors.add :base, "Authentication with stripe failed."
        false
      rescue Stripe::APIConnectionError => e # Network communication with Stripe failed
        logger.error "Message is: #{err[:message]}"
        errors.add :base, "Could not communicate with stripe."
        false
      rescue Stripe::StripeError => e # Display a very generic error to the user, and maybe send # yourself an email
        logger.error "Message is: #{err[:message]}"
        errors.add :base, "An error occured while attempting to charge the care"
        false
      rescue => e # Something else happened, completely unrelated to Stripe end
        logger.error "Message is: #{err[:message]}"
        errors.add :base, "unknown ERROR uccored."
        false
      end
    end
  end

end

