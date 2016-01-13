require 'httparty'

module DarkLinks
  module LinkValidator
    def check_links( text )
      new_links = {}
      links = tokenize_links(text)[:link_tokens]
      links.each do |token, url|
        link_status = check_link(url)
        if link_status == "OK"
          new_links[url] = true
        else
          new_links[url] = false
        end
      end
      new_links
    end

    def check_link( url )
      begin
        response = HTTParty.head(url)
        if response.code == 404
          "Page could not be found"
        else
          "OK"
        end
      rescue Timeout::Error, SocketError => e
        "Can't find server"
      rescue URI::InvalidURIError => e
        "Is not a valid url"
      end
    end

    private
      def tokenize_links( text )
        regex = %r{(http|https)://[^\"\s<]+}
        tokens = {}

        result = text.gsub( regex ) do |link|
          append = ''

          url = link.gsub(/[^\w\/-=&]\z/) do |char|
            append = char
            ''
          end

          sha = Digest::SHA1.hexdigest(url)
          tokens = tokens.merge( sha => url )

          "[[link:#{sha}]]#{append}"
        end
        { body: result, link_tokens: tokens }
      end
  end
end