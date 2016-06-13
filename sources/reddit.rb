class Reddit

	def initialize
		@resource =  (Service.new("http://reddit.com/.json")).resource
	end

	def get_news
		news = []
		@resource['data']['children'].each do |item|
			news << FilterNews.new(item)
		end
		news
	end

	private

	class FilterNews

		attr_reader :title, :author, :date, :url, :source

		def initialize (news_hash)
			@title = news_hash['data']['title']
			@author = news_hash['data']['author']
			@date = news_hash['data']['created_utc']
			@url = news_hash['data']['url']
			@source = "Reddit"
		end
	end
end
