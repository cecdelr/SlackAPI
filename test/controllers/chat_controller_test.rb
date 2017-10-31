require 'test_helper'

class ChatControllerTest < ActionDispatch::IntegrationTest
  describe "index" do
    it "succeeds with many channels" do
      VCR.use_cassette("root_path") do
        get root_path
        must_respond_with :success

      end
    end
  end

  describe "new" do
    it "generates the form for a valid channel" do
      VCR.use_cassette("chat_new") do
        channels = SlackApiWrapper.list_channels
        get chat_new_path(channels.first.name)
        must_respond_with :success
      end
    end

    it "redirects to the channel lists if it goes to an invalid channel" do
      VCR.use_cassette("chat_new") do
        get chat_new_path("bogus-channel-name")
        must_respond_with :redirect
      end
    end
  end

  describe "create" do
    it "sends a message to channel and redirects user back to " do
      VCR.use_cassette("chat_create") do
        message_data = {
          message: "boot boot"
        }

        post chat_create_path("test-api-channel"), params: message_data
        must_respond_with :redirect
      end
    end

    it "sends a message to channel and redirects user back to " do
      VCR.use_cassette("chat_create") do
        message_data = {
          message: "boot boot"
        }

        post chat_create_path("test-api-channel"), params: message_data
        must_respond_with :redirect
        #MERP
      end
    end
  end
end
