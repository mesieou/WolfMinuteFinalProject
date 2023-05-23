class MeetingsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id]) || current_user
    @meetings = @user.meetings.where(
      start_date: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
    )
    @users = User.all
  end

  def show
    @meeting = Meeting.find(params[:id])
    @booking = @meeting.bookings
    @attendance = @meeting.bookings.map { |booking| booking.user }
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
    @users_names = params[:users]
    if @meeting.save
      @users_names.each do |name|
        @user_instance = User.where(name: name).first
        @booking = Booking.create(user: @user_instance, meeting: @meeting)
        @meeting.bookings << @booking
      end
      redirect_to meetings_path
    else
      render :new, status: :unprocessable_entity
    end
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
    params.require(:meeting).permit(:status, :user_id, :start_date, :description, :location, :duration, :title)
  end
end
