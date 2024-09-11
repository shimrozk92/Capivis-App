class FraudAddressData < ApplicationRecord
  # This method returns records that partially or fully match the given address, city, state, or zip code
  def self.search(query)
    where("address_line_1 LIKE ? OR city LIKE ? OR state LIKE ? OR zip_code LIKE ?",
          "%#{query[:address_line_1]}%", "%#{query[:city]}%", "%#{query[:state]}%", "%#{query[:zip_code]}%")
  end
end
