class Comment < ApplicationRecord
  enum status: [:published, :unpublished, :not_set]
  validates :content, presence: true, length: {minimum: 1, maximum: 300}
  belongs_to :article
end
