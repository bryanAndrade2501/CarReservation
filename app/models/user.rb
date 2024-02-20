class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true, length: {minimum: 6}
    validates :name, presence: true
    validates :username, presence: true, uniqueness: true, 
        length: { in: 6..15},
        format: {
            with: /\A[a-z-A-Z-0-9]+\z/,
            message: :invalid
        }

    has_many :reservations, dependent: :destroy
    has_many :messages, dependent: :destroy

    before_save :downcase_attributes

    scope :all_except, ->(user) { where.not(id: user) }

    #after_create_commit { broadcast_append_to "users" }

    private

    def downcase_attributes
        self.username = username.downcase
        self.email = email.downcase
    end

end
