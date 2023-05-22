class MeetingsController < ApplicationController

  def show
    @meeting = Meeting.find(:params[:id])
    @booking = @meeting.bookings
  end

end
