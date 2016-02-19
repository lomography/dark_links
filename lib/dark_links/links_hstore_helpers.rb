    def self.link_status( links_hash )
      if links.blank?
        :none
      elsif links.any? { |k, v| v == "false" }
        :error
      else
        :ok
      end
    end

    def links_with_errors
      links.select { |k, v| v == "false" } .map { |k, v| k }
    end