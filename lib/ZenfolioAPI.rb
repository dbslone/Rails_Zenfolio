require "ZenfolioAPI/version"
require "ZenfolioAPI/authentication"
require "ZenfolioAPI/session"
require "ZenfolioAPI/http"
require "ZenfolioAPI/record"
require "ZenfolioAPI/model/gallery"
require "ZenfolioAPI/model/image"
require "ZenfolioAPI/model/exif_tag"
require "ZenfolioAPI/model/access_descriptor"

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
