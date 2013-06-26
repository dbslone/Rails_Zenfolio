require 'date'

module ZenfolioAPI
	class Session
		attr_accessor :galleries
		attr_accessor :photos
		attr_accessor :groups

		# Create the Zenfolio Session
		#
		# @author David Slone
		def initialize username, password
			@username = username
			@password = password
			@auth = ZenfolioAPI::Authentication.new(username, password)

			@galleries = []
			@photos = []
			@groups = []
		end

		# Performs the API request to the Zenfolio server
		#
		# @author David Slone
		def api_request method, params
			connection = ZenfolioAPI::HTTP.new()
			@response = connection.POST(method, params, @auth.token)
		end

		# The LoadGroupHierarchy method obtains a snapshot of the entire photoset group hierarchy of the specified user.
		#
		# @author David Slone
		# @return [Hash] Returns a hash that contains the Galleries and Groups at the top level for a users account.
		def list_galleries
			@response = api_request 'LoadGroupHierarchy', [@username]

			@response['result']['Elements'].each do |value|
				if value['$type'] == "PhotoSet"
					@galleries << ZenfolioAPI::Model::Gallery.new(:id => value['Id'], :type => value['$type'], :caption => value['Caption'], 
						:created_on => value['CreatedOn']['Value'], :modified_on => value['ModifiedOn']['Value'], :photo_count => value['PhotoCount'],
						:image_count => value['ImageCount'], :video_count => value['VideoCount'], :photo_bytes => value['PhotoBytes'], :views => value['Views'],
						:featured_index => value['FeaturedIndex'], :is_random_title_photo => value['IsRandomTitlePhoto'], :upload_url => value['UploadUrl'],
						:video_upload_url => value['VideoUploadUrl'], :page_url => value['PageUrl'], :mailbox_id => value['MailboxId'], :text_cn => value['TextCn'], 
						:photo_list_cn => value['PhotoListCn'], :group_index => value['GroupIndex'], :title => value['Title'], :owner => value['Owner'])
				elsif value['$type'] == "Group"	
					elements = []
					value['Elements'].each do |element|
						if element['$type'] == "PhotoSet"
							elements << ZenfolioAPI::Model::Gallery.new(:id => element['Id'], :type => element['$type'], :caption => element['Caption'], 
								:created_on => element['CreatedOn']['Value'], :modified_on => element['ModifiedOn']['Value'], :photo_count => element['PhotoCount'],
								:image_count => element['ImageCount'], :video_count => element['VideoCount'], :photo_bytes => element['PhotoBytes'], :views => element['Views'],
								:featured_index => element['FeaturedIndex'], :is_random_title_photo => element['IsRandomTitlePhoto'], :upload_url => element['UploadUrl'],
								:video_upload_url => element['VideoUploadUrl'], :page_url => element['PageUrl'], :mailbox_id => element['MailboxId'], :text_cn => element['TextCn'], 
								:photo_list_cn => element['PhotoListCn'], :group_index => element['GroupIndex'], :title => element['Title'], :owner => element['Owner'])
						else
							group_elements = load_group element['Id']
							elements << ZenfolioAPI::Model::Group.new(:id => element['Id'], :created_on => element['CreatedOn']['Value'], :modified_on => element['ModifiedOn']['Value'], 
								:page_url => element['PageUrl'], :mailbox_id => element['MailboxId'], :immediate_children_count => value['ImmediateChildrenCount'], :text_cn => element['TextCn'], 
								:caption => element['Caption'], :collection_count => value['CollectionCount'], :sub_group_count => value['SubGroupCount'], :gallery_count => value['GalleryCount'],
								:featured_index => element['FeaturedIndex'], :is_random_title_photo => element['IsRandomTitlePhoto'], :upload_url => element['UploadUrl'],
								:photo_count => value['PhotoCount'], :parent_groups => value['ParentGroups'], :title => value['Title'])
						end
					end

					@groups << ZenfolioAPI::Model::Group.new(:id => value['Id'], :created_on => value['CreatedOn']['Value'], :modified_on => value['ModifiedOn']['Value'], 
						:page_url => value['PageUrl'], :mailbox_id => value['MailboxId'], :immediate_children_count => value['ImmediateChildrenCount'], :text_cn => value['TextCn'],
						:caption => value['Caption'], :collection_count => value['CollectionCount'], :sub_group_count => value['SubGroupCount'], :gallery_count => value['GalleryCount'],
						:photo_count => value['PhotoCount'], :parent_groups => value['ParentGroups'], :elements => elements, :title => value['Title'])
				end
			end

			{:galleries => @galleries, :groups => @groups}
		end

		# List images for a specific gallery
		#
		# @author David Slone
		# @param [Integer] gallery_id 64-bit identifier of the photoset/gallery to load
		# @param [String] info_level Specifies which PhotoSet snapshot fields to return. This parameter is new in API version 1.4.
		# @param [String] include_photos Specifies whether to return photoset photos. This parameter is new in API version 1.4.
		def images_for_gallery gallery_id, info_level = "Full", include_photos = "true"
			@response = api_request 'LoadPhotoSet', [gallery_id, info_level, include_photos]
			raise ZenfolioAPI::ZenfolioAPISessionError, @response['error']['message'] if @response['result'].nil? && @response['error'].length > 0

			@response['result']['Photos'].each do |value|
				access_descriptor = ZenfolioAPI::Model::AccessDescriptor.new(:realm_id => value['AccessDescriptor']['RealmId'], 
					:access_type => value['AccessDescriptor']['AccessType'], :is_derived => value['AccessDescriptor']['IsDerived'], 
					:access_mask => value['AccessDescriptor']['AccessMask'], :password_hint => value['AccessDescriptor']['PasswordHint'], 
					:src_password_hint => value['AccessDescriptor']['SrcPasswordHint'])

				@photos << ZenfolioAPI::Model::Image.new(:id => value['Id'], :width => value['Width'], :height => value['Height'], :sequence => value['Sequence'], 
					:access_descriptor => access_descriptor, :owner => value['Owner'], :title => value['Title'], :mime_type => value['MimeType'], 
					:size => value['Size'], :gallery => value['Gallery'], :original_url => value['OriginalUrl'], :url_core => value['UrlCore'], 
					:url_host => value['UrlHost'], :url_token => value['UrlToken'], :page_url => value['PageUrl'], :mailbox_id => value['MailboxId'], 
					:text_cn => value['TextCn'], :flags => value['Flags'], :is_video => value['IsVideo'], :duration => value['Duration'], :caption => value['Caption'], 
					:file_name => value['FileName'], :uploaded_on => value['UploadedOn']['Value'], :taken_on => value['TakenOn']['Value'], :keywords => value['keywords'], 
					:categories => value['Categories'], :copyright => value['Copyright'], :rotation => value['Rotation'], :exif_tags => value['ExifTags'], :short_exif => value['ShortExif'])
			end

			@photos
		end

		# The LoadMessages method loads comments or guestbook entries posted to a mailbox.
		#
		# @author David Slone
		def get_mailbox_messages mailbox_id, posted_since = "", include_deleted = "false"
			posted_since = Date.today if posted_since.length == 0

			@response = api_request 'LoadMessages', [mailbox_id, posted_since, include_deleted]
			raise ZenfolioAPI::ZenfolioAPISessionError, @response['error']['message'] if @response['result'].nil? && @response['error'].length > 0

			
		end

		# The LoadGroup method obtains a snapshot of the specified photoset group.
		#
		# @author David Slone
		# @param [Integer] group_id 64-bit identifier of the photoset group to load
		# @param [String] info_level Specifies which Group snapshot fields to return. This parameter is new in API version 1.4.
		# @param [String] include_children Indicates whether to return immediate group children. This parameter is new in API version 1.4.
		# @return [Array] Returns an array of elements from the group. Elements can be Galleries or Groups.
		def load_group group_id, info_level = "Full", include_children = "true"
			@response = api_request 'LoadGroup', [group_id, info_level, include_children]
			raise ZenfolioAPI::ZenfolioAPISessionError, @response['error']['message'] if @response['result'].nil? && @response['error'].length > 0

			elements = []
			@response['result']['Elements'].each do |element|
				if element['$type'] == "PhotoSet"
					elements << ZenfolioAPI::Model::Gallery.new(:id => element['Id'], :type => element['$type'], :caption => element['Caption'], 
						:created_on => element['CreatedOn']['Value'], :modified_on => element['ModifiedOn']['Value'], :photo_count => element['PhotoCount'],
						:image_count => element['ImageCount'], :video_count => element['VideoCount'], :photo_bytes => element['PhotoBytes'], :views => element['Views'],
						:featured_index => element['FeaturedIndex'], :is_random_title_photo => element['IsRandomTitlePhoto'], :upload_url => element['UploadUrl'],
						:video_upload_url => element['VideoUploadUrl'], :page_url => element['PageUrl'], :mailbox_id => element['MailboxId'], :text_cn => element['TextCn'], 
						:photo_list_cn => element['PhotoListCn'], :group_index => element['GroupIndex'], :title => element['Title'], :owner => element['Owner'])
				else
					group_elements = load_group element['Id']
					elements << ZenfolioAPI::Model::Group.new(:id => element['Id'], :created_on => element['CreatedOn']['Value'], :modified_on => element['ModifiedOn']['Value'], 
						:page_url => element['PageUrl'], :mailbox_id => element['MailboxId'], :immediate_children_count => element['ImmediateChildrenCount'], :text_cn => element['TextCn'], 
						:caption => element['Caption'], :collection_count => element['CollectionCount'], :sub_group_count => element['SubGroupCount'], :gallery_count => element['GalleryCount'],
						:featured_index => element['FeaturedIndex'], :is_random_title_photo => element['IsRandomTitlePhoto'], :upload_url => element['UploadUrl'],
						:photo_count => element['PhotoCount'], :parent_groups => element['ParentGroups'], :title => element['Title'])
				end
			end

			elements
		end

		# The LoadPhotoSet method obtains a snapshot of the specified photoset (gallery or collection).
		#
		# @author David Slone
		# @param [Integer] gallery_id 64-bit identifier of the photoset/gallery to load
		# @param [String] info_level Specifies which PhotoSet snapshot fields to return. This parameter is new in API version 1.4.
		# @param [String] include_photos Specifies whether to return photoset photos. This parameter is new in API version 1.4.
		def load_photo_set gallery_id, info_level = "Full", include_photos = "false"
			@response = api_request 'LoadPhotoSet', [gallery_id, info_level, include_photos]
			raise ZenfolioAPI::ZenfolioAPISessionError, @response['error']['message'] if @response['result'].nil? && @response['error'].length > 0

			@response['result']

			photo_set = ZenfolioAPI::Model::Gallery.new(:id => value['Id'], :type => value['$type'], :caption => value['Caption'], 
				:created_on => value['CreatedOn']['Value'], :modified_on => value['ModifiedOn']['Value'], :photo_count => value['PhotoCount'],
				:image_count => value['ImageCount'], :video_count => value['VideoCount'], :photo_bytes => value['PhotoBytes'], :views => value['Views'],
				:featured_index => value['FeaturedIndex'], :is_random_title_photo => value['IsRandomTitlePhoto'], :upload_url => value['UploadUrl'],
				:video_upload_url => value['VideoUploadUrl'], :page_url => value['PageUrl'], :mailbox_id => value['MailboxId'], :text_cn => value['TextCn'], 
				:photo_list_cn => value['PhotoListCn'], :group_index => value['GroupIndex'], :title => value['Title'], :owner => value['Owner'])

			photo_set
		end
	end
end