class TransactionsController < ApplicationController
    def create
        transaction_params = params.require(:transaction).permit(:amount, :transaction_type, :target_wallet_id, :source_wallet_id)
        
        # Check if the transaction is a debit
        if transaction_params[:transaction_type] == "debit"
            source_wallet = Wallet.find_by(id: transaction_params[:source_wallet_id])
            # Check if the balance is sufficient
            if source_wallet.balance < transaction_params[:amount]
                return render json: { error: 'Insufficient funds' }, status: :unprocessable_entity
            end
        else
            target_wallet = Wallet.find_by(id: transaction_params[:target_wallet_id])
        end
    
        # Proceed to create the transaction
        transaction = Transaction.new(transaction_params)
    
        if transaction.save
            update_wallet_balance(transaction)
            render json: transaction, status: :created
        else
            render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
        end
    end
  
    private
  
    def update_wallet_balance(transaction)
    
        # Update balance based on transaction type
        if transaction.transaction_type == "debit"
            source_wallet = Wallet.find(transaction.source_wallet_id)
            source_wallet.update(balance: source_wallet.balance - transaction.amount)
        elsif transaction.transaction_type == "credit"
            target_wallet = Wallet.find(transaction.target_wallet_id)
            target_wallet.update(balance: target_wallet.balance + transaction.amount)
        end
    end
end