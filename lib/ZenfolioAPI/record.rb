module ZenfolioAPI
	class Record
		def initialize params
			return if params.nil?

			params.each do |key, value|
				name = key.to_s
				instance_variable_set("@#{name}", value) if respond_to?(name)
			end
		end

		# Display Gallery is JSON format
		#
		# @author David Slone
		def to_json
			self.instance_variable_hash
		end

		def instance_variable_hash
			Hash[instance_variables.map { |name| [name[1..-1], instance_variable_get(name)] } ]
		end
	end
end