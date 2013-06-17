module ZenfolioAPI
	class Model
		class Image < ZenfolioAPI::Record

			#
			# Level 1 Fields
			#
			attr_reader :id
			attr_reader :width
			attr_reader :height
			attr_reader :sequence
			attr_reader :access_descriptor
			attr_reader :owner
			attr_reader :title
			attr_reader :mime_type
			attr_reader :views
			attr_reader :size
			attr_reader :gallery
			attr_reader :original_url
			attr_reader :url_core
			attr_reader :url_host
			attr_reader :url_token
			attr_reader :page_url
			attr_reader :mailbox_id
			attr_reader :text_cn
			attr_reader :flags
			attr_reader :is_video
			attr_reader :duration

			#
			# Level 2 Fields
			#
			attr_reader :caption
			attr_reader :file_name
			attr_reader :uploaded_on
			attr_reader :taken_on
			attr_reader :keywords
			attr_reader :categories
			attr_reader :copyright
			attr_reader :rotation
			attr_reader :exif_tags
			attr_reader :short_exif
		end
	end
end