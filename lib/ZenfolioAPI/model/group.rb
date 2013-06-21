module ZenfolioAPI
	class Model
		class Group < ZenfolioAPI::Record
			attr_reader :id
			attr_reader :created_on
			attr_reader :modified_on
			attr_reader :page_url
			attr_reader :title
			attr_reader :tile_photo
			attr_reader :mailbox_id
			attr_reader :immediate_children_count
			attr_reader :text_cn

			# Level 2 fields
			attr_reader :caption

			# Full Level fields
			attr_reader :collection_count
			attr_reader :sub_group_count
			attr_reader :gallery_count
			attr_reader :photo_count
			attr_reader :parent_groups

			# Other fields
			attr_reader :elements
		end
	end
end