class Debit < Transaction
    before_create :decrease_balance
  
    def decrease_balance
        # Debits decrease the source wallet balance
        if source_wallet.present? && source_wallet.balance >= amount
            source_wallet.balance -= amount
            source_wallet.save
        else
            errors.add(:source_wallet, 'Insufficient funds or source wallet cannot be nil')
            throw :abort
        end
    end
end