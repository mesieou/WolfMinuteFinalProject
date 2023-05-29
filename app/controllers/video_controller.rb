require 'opentok'
class VideoController < ApplicationController
  before_action :set_opentok_vars
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def set_opentok_vars
    @api_key = ENV['OPENTOK_API_KEY']
    @api_secret = ENV['OPENTOK_API_SECRET']
    @session_id = Session.create_or_load_session_id
    @moderator_name = ENV['MODERATOR_NAME']
    @meeting = Meeting.find(params[:meeting_id])
    @name ||= @meeting.title
    @token = Session.create_token(@name, @moderator_name, @session_id)
  end

  def name
    redirect_to meeting_party_url(@meeting)
  end

  def screenshare
    @darkmode = 'dark'
  end

  private

  def name_params
    params.permit(:name, :password, :authenticity_token, :commit)
  end
end
