class SurveyParticipantsController < ApplicationController
  # GET /survey_participants
  # GET /survey_participants.json
  def index
    @survey_participants = SurveyParticipant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @survey_participants }
    end
  end

  # GET /survey_participants/1
  # GET /survey_participants/1.json
  def show
    @survey_participant = SurveyParticipant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @survey_participant }
    end
  end

  # GET /survey_participants/new
  # GET /survey_participants/new.json
  def new
    @survey_participant = SurveyParticipant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @survey_participant }
    end
  end

  # GET /survey_participants/1/edit
  def edit
    @survey_participant = SurveyParticipant.find(params[:id])
  end

  # POST /survey_participants
  # POST /survey_participants.json
  def create
    @survey_participant = SurveyParticipant.new(params[:survey_participant])    
    respond_to do |format|      
      if @survey_participant.save
        session[:user_id] = @survey_participant.id
        format.html { redirect_to @survey_participant, notice: 'Survey participant was successfully created.' }
        format.js {}
        format.json { render json: @survey_participant, status: :created, location: @survey_participant }
      else
        format.html { render action: "new" }
        format.js {}
        format.json { render json: @survey_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /survey_participants/1
  # PUT /survey_participants/1.json
  respond_to :js, only: [:update]
  def update
    if !session[:user_id]
      @session_expired = true
    else
      @survey_participant = SurveyParticipant.find(params[:id])
      @survey_participant.update_attributes(params[:attrs])
    end  
    
    
    # respond_to do |format|
    #   if @survey_participant.update_attributes(params[:survey_participant])
    #     format.html { redirect_to @survey_participant, notice: 'Survey participant was successfully updated.' }
    #     format.js {}
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: "edit" }
    #     format.json { render json: @survey_participant.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /survey_participants/1
  # DELETE /survey_participants/1.json
  def destroy
    @survey_participant = SurveyParticipant.find(params[:id])
    @survey_participant.destroy

    respond_to do |format|
      format.html { redirect_to survey_participants_url }
      format.json { head :no_content }
    end
  end
end
