class MeetingsController < ApplicationController
  def show
    @meeting = Meeting.find(params[:id])
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      redirect_to meetings_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end
