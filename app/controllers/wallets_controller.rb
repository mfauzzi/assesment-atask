class WalletsController < ApplicationController
    def create
        @wallet = Wallet.new(wallet_params)
        
        if @wallet.save
            render json: @wallet, status: :created
        else
            render json: @wallet.errors, status: :unprocessable_entity
        end
    end
  
    def index
        @wallets = Wallet.all
        render json: @wallets
    end
  
    def show
        @wallet = Wallet.find(params[:id])
        render json: @wallet
    end
  
    private
  
    def wallet_params
        params.require(:wallet).permit(:entity_type, :entity_id, :balance)
    end
end