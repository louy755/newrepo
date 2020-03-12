class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :people, dependent: :destroy
  has_many :layrecs, dependent: :destroy
  has_many :exrecs, dependent: :destroy
end
