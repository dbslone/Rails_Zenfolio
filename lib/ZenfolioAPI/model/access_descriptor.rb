module ZenfolioAPI
	class Model
		class Image < ZenfolioAPI::Record
			attr_reader :realm_id
			attr_reader :access_type
			attr_reader :access_mask
			attr_reader :viewers
			attr_reader :is_derived
			attr_reader :password_hint
			attr_reader :src_password_hint
		end
	end
end