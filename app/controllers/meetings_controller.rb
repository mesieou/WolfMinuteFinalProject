class MeetingsController < ApplicationController
  def index
    @meetings = policy_scope(Meeting.where(
      start_date: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
    ))
  end

  def show
    @meeting = Meeting.find(:params[:id])
    @booking = @meeting.bookings
    authorize @meeting
  end

  def new
    @meeting = Meeting.new
    if params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @users_filtered = []
    end
    respond_to do |format|
      format.html
      format.text{ render partial: "list", locals: { users: @users_filtered }, formats: [:html] }
    end
    authorize @meeting
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
    @users_names = params[:users]
    # raise
    authorize @meeting
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
    params.require(:meeting).permit(:status, :user_id, :start_date, :description, :location, :duration, :title)
  end
end
