class Task < ApplicationRecord
    belongs_to :user

    validates :titulo, presence: true
    validates :descricao, presence: true, length: { minimum: 10 }
end
