class ChatController < ApplicationController
  def index
    @channels = SlackApiWrapper.list_channels
  end

  def new
    @channel = params[:channel]
    if !@channel
      redirect_to root_path
    end
  end

  def create
    msg = params[:message]
    channel = params[:channel]

    if SlackApiWrapper.send_message(channel, msg)
      redirect_to root_path
    else
      render :new
    end
  end
end
