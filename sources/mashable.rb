class Mashable
	def initialize
		@resource =  (Service.new("http://mashable.com/stories.json")).resource
	end

	def get_news
		news = []
		@resource['new'].each do |item|
			news << FilterNews.new(item)
		end
		news
	end

	private

	class FilterNews

		attr_reader :title, :author, :date, :url, :source

		def initialize (news_hash)
			@title = news_hash['title']
			@author = news_hash['author']
			d = news_hash['post_date_rfc']
			@date = (Time.new(d[12..15].to_i, d[8..10], d[5..6].to_i, d[17..18].to_i, d[20..21].to_i, d[23..24].to_i, d[26..28]+':'+d[29..30])).to_i
			@url = news_hash['link']
			@source = "Mashable"
		end
	end
end
