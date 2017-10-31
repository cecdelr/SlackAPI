require 'test_helper'

describe SlackApiWrapper do
    it "Can list a group of channels" do

      VCR.use_cassette("channels") do
        channels = SlackApiWrapper.list_channels
        channels.must_be_instance_of Array
        channels.length.must_be :>, 0
        channels.each do |channel|
          channel.must_be_instance_of Channel
        end
      end

    end

    it "Will return [] for a broken request" do
      VCR.use_cassette("channels") do
        channels = SlackApiWrapper.list_channels("BOGUS")
        channels.must_be_instance_of Array
        channels.must_equal []
      end
    end
end

describe "send_msg" do
  it "can send a message to a channel" do
    VCR.use_cassette("send_message") do
      response = SlackApiWrapper.send_message "test-api-channel", "test bot beep beep"
      response.must_equal true
    end
  end

  it "returns false if it sends a message to an invalid channel" do
    VCR.use_cassette("send_message") do
      response = SlackApiWrapper.send_message "boopy-bot-channel", "beep boop bop"
      response.must_equal false
    end
  end
end
