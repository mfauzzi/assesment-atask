class Credit < Transaction
    before_create :increase_balance
  
    def increase_balance
        # Credits increase the target wallet balance
        if target_wallet.present?
            target_wallet.balance += amount
            target_wallet.save
        else
            errors.add(:target_wallet, 'Target wallet cannot be nil for credit transactions')
            throw :abort
        end
    end
end