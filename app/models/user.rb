class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: { regular: 0, admin: 1 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
    has_many :reservations, dependent: :destroy
    has_many :reserved_showtimes, through: :reservations, source: :showtime
end
