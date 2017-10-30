require "httparty"

class SlackApiWrapper
  # Your code here!
  BASE_URL = "https://slack.com/api/"
  TOKEN = ENV["SLACK_TOKEN"]

  def self.list_channels
    url = BASE_URL + "channels.list?token=#{TOKEN}" + "&exclude_archived=1" # 1 = true, 0 = false

    data = HTTParty.get(url)

    if data["channels"]
      my_channels = data["channels"].map do |channel_hash|
        Channel.new(
          channel_hash["name"],
          channel_hash["id"],
          purpose: channel_hash["purpose"],
          is_archived: channel_hash["is_archived"],
          is_general: channel_hash["is_general"],
          members: channel_hash["members"])
      end
      return my_channels
    else
      return[]
    end
  end

  def self.send_message(channel, msg)
    puts "Sending #{msg} to channel #{channel}"

    url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}"

    response = HTTParty.post(url,
                             body: {
                               "text" => "#{msg}",
                               "channel" => "#{channel}",
                               "username" => "Poop Bot",
                               "icon_emoji" => ":hankey:",
                               "as_user" => "false"
                             },
                             :headers => { 'Content-Type' => "application/x-www-form-urlencoded"}
    )

    return response.success?
  end
end
