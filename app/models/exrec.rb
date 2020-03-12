class Exrec < ApplicationRecord
  belongs_to :user
  has_many :exgoods, dependent: :destroy
  has_many :exdlvs, dependent: :destroy
end
