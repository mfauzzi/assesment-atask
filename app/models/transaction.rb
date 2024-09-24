class Transaction
    include Mongoid::Document
    include Mongoid::Timestamps
  
    field :amount, type: BigDecimal
    field :transaction_type, type: String  # e.g., "credit" or "debit"
    field :source_wallet_id, type: BSON::ObjectId
    field :target_wallet_id, type: BSON::ObjectId
  
    belongs_to :source_wallet, class_name: 'Wallet', optional: true
    belongs_to :target_wallet, class_name: 'Wallet', optional: true
  
    validates :amount, presence: true
    validates :transaction_type, inclusion: { in: %w[credit debit] }
  
    # Callbacks to update wallet balances
    # after_create :update_wallet_balance
  
    private
  
    # def update_wallet_balance
    #     # binding.pry
    #     if transaction_type == 'credit'
    #         target_wallet = Wallet.find(target_wallet_id)
    #         target_wallet.update_balance(amount) if target_wallet
    #     elsif transaction_type == 'debit'
    #         source_wallet = Wallet.find(source_wallet_id)
    #         source_wallet.update_balance(-amount) if source_wallet
    #     end
    # end
end  