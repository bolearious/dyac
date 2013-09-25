class Correction < ActiveRecord::Base
  attr_accessible :replacement
  
  belongs_to :custom_word
end
