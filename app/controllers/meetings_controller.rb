class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end


  def show
    @meeting = Meeting.find(:params[:id])
    @booking = @meeting.bookings
  end

end
