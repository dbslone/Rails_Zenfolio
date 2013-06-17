module ZenfolioAPI
	class Model
		class Gallery < ZenfolioAPI::Record
			attr_reader :id
			attr_reader :type
			attr_reader :caption
			attr_reader :created_on
			attr_reader :modified_on
			attr_reader :photo_count
			attr_reader :image_count
			attr_reader :video_count
			attr_reader :photo_bytes
			attr_reader :views
			attr_reader :type
			attr_reader :featured_index
			attr_reader :title_photo
			attr_reader :is_random_title_photo
			attr_reader :parent_groups
			attr_reader :title
			attr_reader :keywords
			attr_reader :upload_url
			attr_reader :video_upload_url
			attr_reader :owner
			attr_reader :page_url
			attr_reader :mailbox_id
			attr_reader :text_cn
			attr_reader :photo_list_cn
			attr_reader :group_index
			attr_reader :hide_branding
		end
	end
end