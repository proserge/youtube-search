class SearchExecutor
  def initialize(search_string = 'game')
    api_key = Rails.application.credentials.api_key
    max_results = 50
    @url = "https://www.googleapis.com/youtube/v3/search?" \
            "key=#{api_key}" \
            "&part=snippet" \
            "&type=channel" \
            "&q=#{search_string}" \
            "&maxResults=#{max_results}"
  end
  
  def call
    url_base = @url
    list = []
    num = 1
    20.times do
      response = HTTParty.get(@url)
     
      http_code =response.code.to_s
      results = response.parsed_response
      case http_code
      when '200'
        results['items'].each do |item|
          split_item = item['snippet']['description'].match(/(.*)(\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b)(.*)/i)
          if split_item.nil?
            list << "##{num}<br>TITLE: #{item['snippet']['title']}<br>DESCRIPTION: #{item['snippet']['description']}"
          else
            list << "##{num}<br>TITLE: #{item['snippet']['title']}<br>DESCRIPTION: #{split_item[1]}<font color='blue'>#{split_item[2]}</font> #{split_item[3]}"
          end
          num += 1
        end
        @url = url_base + "&pageToken=#{results['nextPageToken']}" if results['nextPageToken'].present?
      else
        list << "ERROR CODE: <font color='red'>#{http_code}</font><br>MESSAGE: #{results['error']['message']}"
        break
      end
    end
    list
  end
end

