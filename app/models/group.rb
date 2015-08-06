class Group < ActiveRecord::Base
  validates :title, presence: {message: "請輸入資料"}
  
  has_many :posts
end
