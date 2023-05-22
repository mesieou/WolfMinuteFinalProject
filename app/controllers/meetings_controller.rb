class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end


  def show
    @meeting = Meeting.find(:params[:id])
    @booking = @meeting.bookings
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update(meeting_params)
      redirect_to meetings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy
    redirect_to meetings_path
  end

  private
  def meeting_params
    params.require(:meeting).permit(:status, :user_id, :start_date, :description, :location, :duration)
  end
end
