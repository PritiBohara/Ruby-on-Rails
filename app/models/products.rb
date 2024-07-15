class Products < ApplicationRecord
    validates :name, presence: true
    validates :purchase_price, presence: true
    validates :sales_price, presence: true

    before_create :generate_uuid

    private
  
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end
end
