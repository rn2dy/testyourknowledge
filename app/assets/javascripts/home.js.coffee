# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#survey-form').submit (e) ->
    e.preventDefault()
    survey_attrs = 
      name:        $(@).find('#survey_name').val()
      description: $(@).find('#survey_description').val()
      
    survey = new SurveyBuilder.Models.Survey
    survey.save survey_attrs,
      success: (model) ->
        window.location = "/builder/survey/#{model.get('id')}"
      error: ->
        alert 'failed'