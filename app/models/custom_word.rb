class CustomWord < ActiveRecord::Base
  attr_accessible :word, :correct
  
  belongs_to :user
  has_many :corrections # what the user really meant
end
