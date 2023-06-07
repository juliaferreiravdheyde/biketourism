class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :rides, dependent: :destroy
  has_many :routes
  has_one_attached :photo
  belongs_to :pinned_route, class_name: "Route"
end
