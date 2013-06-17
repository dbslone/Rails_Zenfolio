module ZenfolioAPI
	class Model
		class ExifTag < ZenfolioAPI::Record

			attr_reader :id
			attr_reader :value
			attr_reader :display_value
		end
	end
end