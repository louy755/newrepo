class Goodlay < ApplicationRecord
  belongs_to :layrec
  after_create :capitaliz_col
  private
  def capitaliz_col
    self.update_columns(vendor: self.vendor.capitalize)
    self.update_columns(item: self.item.capitalize)
  end
end
