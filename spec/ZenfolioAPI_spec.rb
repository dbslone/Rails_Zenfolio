require 'spec_helper'

describe ZenfolioAPI do
	session = ZenfolioAPI::Session.new('punndit','punndit1024')

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
		session.images_for_gallery 562597393410974837
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
		session.list_galleries
		inbox = session.get_mailbox_messages session.galleries.first.mailbox_id
	end

end