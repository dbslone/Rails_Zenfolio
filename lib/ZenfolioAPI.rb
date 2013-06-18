require "ZenfolioAPI/version"
require "ZenfolioAPI/authentication"
require "ZenfolioAPI/session"
require "ZenfolioAPI/http"
require "ZenfolioAPI/record"
require "ZenfolioAPI/model/gallery"
require "ZenfolioAPI/model/image"
require "ZenfolioAPI/model/exif_tag"
require "ZenfolioAPI/model/access_descriptor"
require "ZenfolioAPI/model/group"
require "ZenfolioAPI/model/group_element"
require "ZenfolioAPI/model/message"
require "ZenfolioAPI/model/user"

module ZenfolioAPI

	# General Zenfolio error
	class ZenfolioAPIError < StandardError
	end

	# Zenfolio Session Error
	class ZenfolioAPISessionError < StandardError
	end

	# User Authentication Error
	class ZenfolioAPIAuthenticationError < StandardError
	end
end
