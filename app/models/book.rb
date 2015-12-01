class Book < ActiveRecord::Base
	serialize :authors
	validates_uniqueness_of :ISBN10, :ISBN13, :allow_blank => true, :allow_nil => true
  validates :title, :authors, :language, :cover_image_url, presence: true
	has_many :stocks, :dependent => :destroy
	has_many :line_stocks, :dependent => :destroy

	include PgSearch
  pg_search_scope :search_title, :against => [:title]

  def lowest_price
  	price = self.stocks.minimum(:price)
  	price.to_json
	end
end
