class Service
  attr_reader :resource
  def initialize( url )
    @resource =  JSON.parse(RestClient.get url)
  end

end
