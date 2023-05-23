class MeetingsController < ApplicationController
  def index
    @meetings = policy_scope(Meeting)
  end

  def show
    @meeting = Meeting.find(:params[:id])
    @booking = @meeting.bookings
    authorize @meeting
  end

  def new
    @meeting = Meeting.new
    authorize @meeting
  end

  def create
    @meeting = Meeting.new(meeting_params)
    authorize @meeting
    if @meeting.save
      redirect_to meetings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
    authorize @meeting
  end

  def update
    @meeting = Meeting.find(params[:id])
    authorize @meeting
    if @meeting.update(meeting_params)
      redirect_to meetings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    authorize @meeting
    @meeting.destroy
    redirect_to meetings_path
  end

  private
  def meeting_params
    params.require(:meeting).permit(:status, :user_id, :start_date, :description, :location, :duration)
  end
end
