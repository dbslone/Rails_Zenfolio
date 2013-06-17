module ZenfolioAPI
	class Session
		attr_accessor :galleries
		attr_accessor :photos

		# Create the Zenfolio Session
		#
		# @author David Slone
		def initialize username, password
			@username = username
			@password = password
			@auth = ZenfolioAPI::Authentication.new(username, password)

			@galleries = []
			@photos = []
		end

		#
		#
		# @author David Slone
		def api_request method, params
			connection = ZenfolioAPI::HTTP.new()
			@response = connection.POST(method, params, @auth.token)
		end

		#
		#
		# @author David Slone
		def list_galleries
			@response = api_request 'LoadGroupHierarchy', [@username]

			@response['result']['Elements'].each do |value|
				#puts "\n\n"
				#puts value
				#uts value['$type']

				@galleries << ZenfolioAPI::Model::Gallery.new(:id => value['Id'], :type => value['$type'], :caption => value['Caption'], 
					:created_on => value['CreatedOn']['Value'], :modified_on => value['ModifiedOn']['Value'], :photo_count => value['PhotoCount'],
					:image_count => value['ImageCount'], :video_count => value['VideoCount'], :photo_bytes => value['PhotoBytes'], :views => value['Views'],
					:featured_index => value['FeaturedIndex'], :is_random_title_photo => value['IsRandomTitlePhoto'], :upload_url => value['UploadUrl'],
					:video_upload_url => value['VideoUploadUrl'], :page_url => value['PageUrl'], :mailbox_id => value['MailboxId'], :text_cn => value['TextCn'], 
					:photo_list_cn => value['PhotoListCn'], :group_index => value['GroupIndex'], :title => value['Title'], :owner => value['Owner'])
			end

			@galleries.each do |g|
			#	puts g.to_json
				puts "id: #{g.id} :: title: #{g.title}"
			end
		end

		# List images for a specific gallery
		#
		# @author David Slone
		# @params [Integer] gallery_id Identifier for the gallery to retrieve the photos from.
		def images_for_gallery gallery_id, info_level = "Full", include_photos = "true"
			@response = api_request 'LoadPhotoSet', [gallery_id, info_level, include_photos]
			raise ZenfolioAPI::ZenfolioAPISessionError, @response['error']['message'] if @response['result'].nil? && @response['error'].length > 0

			@response['result']['Photos'].each do |value|
				#puts "value:"
				#puts value
				@photos << ZenfolioAPI::Model::Image.new(:id => value['Id'], :width => value['Width'], :height => value['Height'])
			end

			@photos.each do |p|
				p.to_json
			end
		end
	end
end