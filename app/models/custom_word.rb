class CustomWord < ActiveRecord::Base
  attr_accessible :word, :correct
  
  belongs_to :user
  has_many :corrections # what the user really meant
  
  validates_presence_of :word
  validates_uniqueness_of :word, :scope => :user_id, :message => 'is already in your dictionary'
  
  def top_corrections
  	sql= 'SELECT replacement, count(id)  as used ' +
  	'FROM corrections ' +
  	"WHERE custom_word_id=#{id} " +
  	'GROUP BY replacement ' +
  	'ORDER by used desc limit 3'
    Correction.find_by_sql( sql ).collect { |cor| cor.replacement }
  end
  
end
