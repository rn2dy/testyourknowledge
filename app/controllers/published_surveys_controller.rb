class PublishedSurveysController < ApplicationController
  # GET /published_surveys
  # GET /published_surveys.json
  def index
    @published_surveys = PublishedSurvey.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @published_surveys }
    end
  end

  # GET /published_surveys/1
  # GET /published_surveys/1.json
  def show
    @published_survey = PublishedSurvey.find(params[:id])
    @survey = @published_survey.survey
    @questions = @survey.questions
    @survey_participant = SurveyParticipant.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @published_survey }
    end
  end

  # GET /published_surveys/new
  # GET /published_surveys/new.json
  def new
    @published_survey = PublishedSurvey.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @published_survey }
    end
  end

  # GET /published_surveys/1/edit
  def edit
    @published_survey = PublishedSurvey.find(params[:id])
  end

  # POST /published_surveys
  # POST /published_surveys.json
  def create
    @published_survey = PublishedSurvey.new(params[:published_survey])

    respond_to do |format|
      if @published_survey.save
        SurveyMailer.published_survey_email(@published_survey.id).deliver
        format.html { redirect_to @published_survey, notice: 'Published survey was successfully created.' }
        format.json { render json: @published_survey, status: :created, location: @published_survey }
      else
        format.html { render action: "new" }
        format.json { render json: @published_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /published_surveys/1
  # PUT /published_surveys/1.json
  def update
    @published_survey = PublishedSurvey.find(params[:id])

    respond_to do |format|
      if @published_survey.update_attributes(params[:published_survey])
        format.html { redirect_to @published_survey, notice: 'Published survey was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @published_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /published_surveys/1
  # DELETE /published_surveys/1.json
  def destroy
    @published_survey = PublishedSurvey.find(params[:id])
    @published_survey.destroy

    respond_to do |format|
      format.html { redirect_to published_surveys_url }
      format.json { head :no_content }
    end
  end
end
