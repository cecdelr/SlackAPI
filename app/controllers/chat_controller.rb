class ChatController < ApplicationController
  def index
    @channels = SlackApiWrapper.list_channels
  end

  def new
    @channel = params[:channel]
    if !@channel
      flash[:status] = :failure
      redirect_to root_path
    else
      flash[:status] = :success
    end
  end

  def create
    msg = params[:message]
    channel = params[:channel]

    if SlackApiWrapper.send_message(channel, msg)
      flash[:status] = :success
      redirect_to root_path
    else
      flash[:status] = :failure
      render :new
    end
  end
end
