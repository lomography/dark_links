require 'httparty'
require 'uri'
require 'cgi'

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
        response = HTTParty.head(unescape_url(url))

        if response.code < 400
          "OK"
        elsif response.code == 404
          "Page could not be found"
        elsif response.code >= 400 && response.code < 500
          "Client Error"
        elsif response.code >= 500 && response.code < 600
          "Server Error"
        else
          "Unknowen Error"
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
          tokens = tokens.merge( sha => unescape_url(url) )

          "[[link:#{sha}]]#{append}"
        end
        { body: result, link_tokens: tokens }
      end

      def unescape_url( url )
        url = CGI.unescapeHTML( url )
        URI.unescape(url)
      end
  end
end