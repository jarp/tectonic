class LocationService

    def self.lookup(state)
      puts  "[location srv] fetching target location for #{state} from google"
      uri = URI("http://maps.googleapis.com/maps/api/geocode/json?address=#{state}")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(request)
      #puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n#{res.body}\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
      return JSON.parse(res.body)["results"][0]["geometry"]["location"]
    end

    def self.distance(from,to)
        endpoint = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{from.gsub('|',',')}&destinations=#{to.gsub('|',',')}&key=#{ENV['TECTONIC_API']}"
        puts "[location srv] endpoint is: #{endpoint}"
        uri = URI(endpoint)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
        request = Net::HTTP::Get.new(uri.request_uri)
        res = http.request(request)
        puts "[location srv] found distance matrix: #{JSON.parse(res.body)}"
        return JSON.parse(res.body)["rows"][0]["elements"][0]["distance"]["text"]
    end
end
