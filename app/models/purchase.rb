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
      rescue Stripe::InvalidRequestError => e
        logger.error "Stripe error from charge: #{e.message}"
        errors.add :base, "There was a problem with your credit card."
        false
      end
    end
  end

end

