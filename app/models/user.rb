class User < ApplicationRecord

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  has_many :articles
  has_many :comments
   #Validations
   validates_presence_of :name, :email, :password_digest
   validates :email, uniqueness: true

   #encrypt password
   has_secure_password
end
