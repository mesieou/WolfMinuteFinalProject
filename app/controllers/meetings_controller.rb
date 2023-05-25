class MeetingsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id]) || current_user
    if params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @users_filtered = []
    end
    respond_to do |format|
      format.html
      format.text{ render partial: "avatars", locals: { users: @users_filtered }, formats: [:html] }
    end

    @users = User.where.not(id: current_user)
    @meetings = policy_scope(@user.meetings.where(
      start_date: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
    ))
  end

  def show
    @meeting = Meeting.find(params[:id])
    @booking = @meeting.bookings
    @attendance = @meeting.bookings.map { |booking| booking.user }
    authorize @meeting
  end

  def new
    @meeting = Meeting.new
    if params[:description]
      fetch_results
      respond_to do |format|
        format.html
        format.text { render partial: "objectives_and_agenda", locals: { result: @result }, formats: [:html] }
      end
    elsif params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
      respond_to do |format|
        format.html
        format.text { render partial: "list", locals: { users: @users_filtered }, formats: [:html] }
      end
    else
      @users_filtered = []
    end
    authorize @meeting
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.title = get_title_from_chatgpt(params[:meeting][:description])
    @meeting.user = current_user
    @users_names = params[:users]
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
    if params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @users_filtered = []
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    authorize @meeting

    if params[:query] && params[:query] != ""
      @users_filtered = User.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @users_filtered = []
    end

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

  def get_title_from_chatgpt(user_reply)
    title_prompt = "Can you please provide a title for a meeting with
      the following description: #{user_reply}.
      Only reply with the answer and should not be more than
      10 words, example reply: 'Training Session for Next Week'"
    OpenaiService.new(title_prompt).call
  end

  def get_objectives_and_agenda_from_chatgpt(description_reply, start_time, duration)
    objectives_and_agenda_prompt = "Can you please provide a objectives and agenda for a meeting with
      the following description: #{description_reply}.
      Provide only 3 objectives starting from the highest priority to the lowest.
      The meeting starts at #{start_time} and the duration is #{duration} min should have an itemised date(maximum 5 items).
      reply with bullet points. Your reply should only be the Objectives and Agenda. Example answer:
      Objectives:
      - Highest Priority: Assess the potential benefits and drawbacks of adopting the new accounting software
      - Middle Priority: Assess the potential benefits and drawbacks of adopting the new accounting software
      - Low Priority: Assess the potential benefits and drawbacks of adopting the new accounting software

      Agenda:
      1.  11: 00 to 11:05 Introduction and Welcome (5 minutes)
      2.  11: 05 to 11:15 Review of the New Accounting Software (10 minutes)
      3.  11: 15 to 11:25 Pros and Cons Discussion (10 minutes)
      4.  11: 25 to 11:30 Next Steps and Conclusion (5 minutes) '"
    OpenaiService.new(objectives_and_agenda_prompt).call
  end

  def fetch_results
    @result = get_objectives_and_agenda_from_chatgpt(
      params[:description],
      params[:start_date],
      params[:duration]
    )
  end
end
