class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :email,              type: String
  field :encrypted_password, type: String

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, presence: true, on: :create
  before_save { self.email = email.downcase }

  include Mongoid::Timestamps
end
