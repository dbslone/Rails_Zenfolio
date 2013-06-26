require 'spec_helper'

describe ZenfolioAPI do
	session = ZenfolioAPI::Session.new(ENV['ZENFOLIO_USERNAME'],ENV['ZENFOLIO_PASSWORD'])

	it "Should connect to API server" do
		session.should_not be_nil
	end

	it "should list galleries for user" do
		session.list_galleries
	end

	it "should raise exception for incorrect gallery/collection id" do
		expect { session.images_for_gallery 5 }.to raise_error

	end

	it "should list photos for a gallery" do
		photos = session.images_for_gallery 562597392871954814
	end

	it "should load a group" do
		group = session.load_group 562597392652020926
		group.should_not be_nil
	end

	it "shoud list groups for a group" do
		session.list_galleries
		group = session.groups.first
		#group.should_no be_nil
	end

	it "should list photos for a group" do
		session.list_galleries
		session.groups.each do |group|
			group.elements.each do |element|
				session.images_for_gallery element.id
				session.photos.should_not be_nil
			end
		end
	end

	it "should list messages in inbox" do
		#session.list_galleries
		#inbox = session.get_mailbox_messages session.galleries.first.mailbox_id
	end

	it "should load photo set" do
		photo_set = session.load_photo_set 562597392944883636
		photo_set.should_not be_nil
	end

end