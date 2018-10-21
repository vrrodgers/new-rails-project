class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, dependent: :destroy
  
  before_save { self.role ||= :standard }

   enum role: [:standard, :premium, :admin]
end
