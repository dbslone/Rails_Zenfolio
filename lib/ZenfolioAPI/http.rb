module ZenfolioAPI
	class HTTP

		def initialize
			@api_url = "https://api.zenfolio.com/api/1.7/zfapi.asmx"
		end

		#
		#
		# @author David Slone
		def POST method, params = {}, token = nil
			@api_body = {:method => method, :params => params, :id => 1}

			url = URI.parse(@api_url) 
			post = Net::HTTP::Post.new(url.path) 
			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true
			#http.set_debug_output $stderr

			post['X-Zenfolio-User-Agent'] = 'Acme PhotoEdit plugin for Zenfolio v1.0'
			post['User-Agent'] = 'Acme PhotoEdit plugin for Zenfolio v1.0'
			post['X-Zenfolio-Token'] = token unless token.nil?
			post.content_type = 'application/json'
			post.body = @api_body.to_json

			response = http.start {|http| http.request(post) }
			@body = JSON.parse(response.body)
		end
	end
end