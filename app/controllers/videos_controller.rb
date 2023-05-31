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

  def update
    @video = Video.find(params[:id])
    authorize @video
    @video.update(video_params)
    @transcript = GoogleService.new.transcript(@video.audio.url)
    @transcript_summary = summarise_transcript(@transcript)
    @video.transcript = @transcript
    @video.summary = @transcript_summary
    @video.save
  end

  def video_params
    params.require(:video).permit(:summary, :actions, :audio)
  end

  def summarise_transcript(transcript)
    objectives_and_agenda_prompt = "your role is a meeting assistant. A meeting just ended and you need to send a summary email about the meeting discussion. Please create a concise summary in bullet points with the following transcript. Do not include the word summary: #{transcript}"
    OpenaiService.new(objectives_and_agenda_prompt).call
  end
end
