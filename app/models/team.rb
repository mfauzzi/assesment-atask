class Team
    include Mongoid::Document
    has_one :wallet, as: :entity
    field :name, type: String
end