class Post < ApplicationRecord
    validates :title, presence: true, length: { minimum: 1, maximum: 50 }
    validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
    validates :user_id, { presence: true }
    belongs_to :user
end
