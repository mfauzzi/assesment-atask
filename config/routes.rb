Rails.application.routes.draw do
    # Session management (sign-in)
    post '/sessions', to: 'sessions#create'

    # Transactions for credit/debit
    resources :wallets, only: [:create, :show, :index]  # Add these routes for wallets
    resources :transactions, only: [:create]             # Add routes for transactions
end