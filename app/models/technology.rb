class Technology < ApplicationRecord
	has_and_belongs_to_many :tutorials

	validates :title, :slug, :body, presence: true
end
