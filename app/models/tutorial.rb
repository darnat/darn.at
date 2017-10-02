class Tutorial < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :technologies

  validates :title, :body, :slug, :published, :technology_ids, presence: true
end
