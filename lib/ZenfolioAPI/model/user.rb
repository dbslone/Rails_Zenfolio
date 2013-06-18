module ZenfolioAPI
	class Model
		class User < ZenfolioAPI::Record
			attr_reader :login_name
			attr_reader :display_name
			attr_reader :first_name
			attr_reader :last_name
			attr_reader :primary_email
			attr_reader :bio_photo
			attr_reader :bio
			attr_reader :views
			attr_reader :gallery_count
			attr_reader :collection_count
			attr_reader :photo_count
			attr_reader :photo_bytes
			attr_reader :user_since
			attr_reader :last_updated
			attr_reader :public_address
			attr_reader :personal_address
			attr_reader :recent_photo_sets
			attr_reader :featured_photo_sets
			attr_reader :root_group
			attr_reader :referral_code
			attr_reader :expires_on
			attr_reader :balance
			attr_reader :domain_name
			attr_reader :storage_quota
			attr_reader :photo_bytes_quota
			attr_reader :video_bytes_quota
			attr_reader :video_duration_quota
			attr_reader :hierarchy_cn
		end
	end
end