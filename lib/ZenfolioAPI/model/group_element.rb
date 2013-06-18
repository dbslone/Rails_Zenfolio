module ZenfolioAPI
	class Model
		class GroupElement < ZenfolioAPI::Record
			attr_reader :id
			attr_reader :group_index
			attr_reader :title
			attr_reader :access_descriptor
			attr_reader :owner
		end
	end
end