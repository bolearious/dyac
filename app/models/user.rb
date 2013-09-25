class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name
  
  has_many :custom_words # the user may use words aren't quite real
end
