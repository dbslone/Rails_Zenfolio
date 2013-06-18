module ZenfolioAPI
	class Model
		class Gallery < ZenfolioAPI::Record
			attr_reader :index
			attr_reader :mailbox_id
			attr_reader :posted_on
			attr_reader :poster_login_name
			attr_reader :poster_url
			attr_reader :poster_email
			attr_reader :body
			attr_reader :is_private
		end
	end
end