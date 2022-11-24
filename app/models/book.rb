class Book < ApplicationRecord
	belongs_to :user
	
	
  validates :title, presence: true
  validates :body, presence: true
  validates :body,
  length: {only_integer:true,
  greater_than: 0, less_than: 201 }
end
