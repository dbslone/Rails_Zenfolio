module ZenfolioAPI
	class Authentication

		attr_accessor :token

		# Connect to the Zenfolio API
		#
		# @author David Slone
		def initialize username,password
			@api_url = "http://api.zenfolio.com/api/1.7/zfapi.asmx"
			@username = username
			@password = password


			connection = ZenfolioAPI::HTTP.new()
			@response = connection.POST('AuthenticatePlain', [username, password])
			
			# Unable to authenticate the user. Return error code from server
			raise ZenfolioAPI::ZenfolioAPIAuthenticationError, @response['error'] if !@response['error'].nil?

			@token = @response['result']
		end
	end
end