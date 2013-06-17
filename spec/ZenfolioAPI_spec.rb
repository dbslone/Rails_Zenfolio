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
		session.images_for_gallery 562597392584617134
	end

end