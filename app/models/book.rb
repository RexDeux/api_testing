class Book < ApplicationRecord
  belongs_to :category
  def self.search(query)
    where("title LIKE ?", "%#{query}%")
  end
end
