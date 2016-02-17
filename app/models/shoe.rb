class Shoe < ActiveRecord::Base
  belongs_to :user
  validates :name, :presence => true
  validates :price, :presence => true, numericality: true
end
