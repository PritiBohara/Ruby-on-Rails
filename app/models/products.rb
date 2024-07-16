class Products < ApplicationRecord
  validates :name, presence: true
  validates :sales_price, presence: true

  before_create :generate_uuid
  before_save :calculate_purchase_price

  scope :sorted, -> { order(id: :desc) }
  

  attribute :is_inclusive, :boolean, default: false

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def calculate_purchase_price
    if is_inclusive?
      if base_price.present? && gst_percentage.present?
        self.purchase_price = base_price / (100 + gst_percentage) * 100
      end
    else
      self.purchase_price = base_price
    end
  end

  def self.search(search)
    if search.present?
      where("name ILIKE :search OR uuid ILIKE :search", search: "%#{search}%")
    else
      all
    end
  end
end
