class SurveyBuilder.Routers.AppRouter extends Backbone.Router
  initialize: (options)->
    @survey = options['survey']
    @questions = options['questions']
  
  routes:
    ":survey_id" : "builder"
    
  builder: ->
    builderMasterView = new SurveyBuilder.Views.Builder.Master
      model: new SurveyBuilder.Models.Survey(@survey, { parse: true })      
      collection: new SurveyBuilder.Collections.Questions(@questions)
      
    $('#app-container').append builderMasterView.render().el