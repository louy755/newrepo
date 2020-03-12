class Good < ApplicationRecord
  belongs_to :person
  after_create :capitalize_col
  private
  def capitalize_col
    self.update_columns(vendor: self.vendor.capitalize)
    self.update_columns(item: self.item.capitalize)
  end
end
