require 'test_helper'
require 'minitest/spec'
require 'minitest/autorun'

describe Channel do
  it "can be created" do
    my_channel = Channel.new "name", "id"

    my_channel.must_respond_to :name
    my_channel.wont_be_nil
    my_channel.name.must_equal "name"
    my_channel.id.must_equal "id"
  end
end
