class VideosController < ApplicationController

  def create
    @video = Video.new(video_params)
    @video.save
    authorize @video
    @meeting = Meeting.find(params[:meeting_id])
    @meeting.video = @video
    @meeting.save
    redirect_to meeting_path(@meeting)
  end

  def video_params
    params.require(:video).permit(:summary, :actions)
  end
end
