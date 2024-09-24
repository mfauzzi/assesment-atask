class Stock
    include Mongoid::Document
    has_one :wallet, as: :entity
    field :name, type: String
    field :ticker, type: String
end