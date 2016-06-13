class Digg

	def initialize
		@resource =  (Service.new("http://digg.com/api/news/popular.json")).resource
	end

	def get_news
		news = []
		@resource['data']['feed'].each do |item|
			news << FilterNews.new(item)
		end
		news
	end

	private

	class FilterNews

		attr_reader :title, :author, :date, :url, :source

		def initialize (news_hash)
			@title = news_hash['content']['title']
			@author = news_hash['content']['author']
			@date = (news_hash['date'] + 16200)
			@url = news_hash['content']['url']
			@source = "Digg"
		end
	end
end
