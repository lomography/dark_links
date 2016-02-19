require 'test_helper'

module DarkLinks
  class LinkValidatorTest < Minitest::Test
    def test_links_hash_should_reflect_link_status
      stub_request(:any, "http://www.lomography.com/").to_return(status: 200)
      stub_request(:any, "http://www.lomographybrrzl.com/").to_timeout


      links = Text.new.check_links("visit us at http://www.lomography.com ")
      assert_equal [true], links.values

      links = Text.new.check_links("this text does not contain any links")
      assert_equal [], links.values

      links = Text.new.check_links("brzl brzl: http://www.lomographybrrzl.com")
      assert_equal [false], links.values
    end

    def test_links_with_errors
      stub_request(:any, "http://www.lomography.com/").to_return(status: 200)
      stub_request(:any, "http://www.lomography.com/brzlbrzl").to_return(status: 404)
      stub_request(:any, "http://www.lomographybrrzl.com/").to_timeout

      links = Text.new.check_links("wrong: http://www.lomographybrrzl.com, 404: http://www.lomography.com/brzlbrzl, ok: http://www.lomography.com/ ")
      assert_equal false, links["http://www.lomographybrrzl.com"]
      assert_equal false, links["http://www.lomography.com/brzlbrzl"]
      assert_equal true,  links["http://www.lomography.com/"]
    end

    def test_link_with_internal_server_error
      stub_request(:any, "http://www.lomography.com/server_error").to_return(status: 500)

      links = Text.new.check_links("server error: http://www.lomography.com/server_error")
      assert_equal false, links["http://www.lomography.com/server_error"]
    end

    def test_escaped_link
      stub_request(:any, "http://www.nasa.gov/hello?id=42&key=23").to_return(status: 200)
      links = Text.new.check_links("Here is something that you might find in html: <a href=\"http://www.nasa.gov/hello?id=42&amp;key=23\">nasa</a>")
      assert_equal true, links["http://www.nasa.gov/hello?id=42&key=23"]
    end

    def test_https_link
      stub_request(:any, "https://www.nasa.gov/").to_return(status: 200)
      links = Text.new.check_links("Here is something that you might find in html: <a href=\"https://www.nasa.gov/\">nasa</a>")
      assert_equal true, links["https://www.nasa.gov/"]
    end

    def test_server_that_only_allows_get
      stub_request(:head, "http://www.lomography.com/").to_return(status: 405)
      stub_request(:get, "http://www.lomography.com/").to_return(status: 200)

      links = Text.new.check_links("ok: http://www.lomography.com/ ")
      assert_equal true,  links["http://www.lomography.com/"]
    end
  end

  class Text
    include DarkLinks::LinkValidator
  end
end