require 'test_helper'

module DarkLinks
  class LinkValidatorTest < Minitest::Test
    def test_links_hash_should_reflect_link_status
      stub_request(:head, "http://www.lomography.com/").to_return(status: 200)
      stub_request(:head, "http://www.lomographybrrzl.com/").to_timeout


      links = Text.new.check_links("visit us at http://www.lomography.com ")
      assert_equal [true], links.values

      links = Text.new.check_links("this text does not contain any links")
      assert_equal [], links.values

      links = Text.new.check_links("brzl brzl: http://www.lomographybrrzl.com")
      assert_equal [false], links.values
    end

    def test_links_with_errors
      stub_request(:head, "http://www.lomography.com/").to_return(status: 200)
      stub_request(:head, "http://www.lomography.com/brzlbrzl").to_return(status: 404)
      stub_request(:head, "http://www.lomographybrrzl.com/").to_timeout

      links = Text.new.check_links("wrong: http://www.lomographybrrzl.com, 404: http://www.lomography.com/brzlbrzl, ok: http://www.lomography.com/ ")
      assert_equal false, links["http://www.lomographybrrzl.com"]
      assert_equal false, links["http://www.lomography.com/brzlbrzl"]
      assert_equal true,  links["http://www.lomography.com/"]
    end
  end

  class Text
    include DarkLinks::LinkValidator
  end
end