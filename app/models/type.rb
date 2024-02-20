class Type < ApplicationRecord
  has_many :cars, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true
end
