class Wallet
    include Mongoid::Document
    include Mongoid::Timestamps

    field :entity_type, type: String  # Define entity_type as a String
    field :entity_id, type: String    # Define entity_id as a String
    field :balance, type: Float, default: 0.0  # Define balance as a Float with a default value

    validates :entity_type, presence: true
    validates :entity_id, presence: true
    validates :balance, numericality: { greater_than_or_equal_to: 0 }
  
    # Method to update balance
    def update_balance(amount)
        self.balance += amount
        save!
    end
end
  