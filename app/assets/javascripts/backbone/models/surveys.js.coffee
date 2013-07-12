class SurveyBuilder.Models.Survey extends Backbone.Model
  paramRoot: 'survey'
  urlRoot: '/surveys'
  
  defaults:
    name: 'Unknown'
    description: 'Unknown'
    question_ids: []
      
  addNewQuestion: (qid) ->
    ids = @get('question_ids')
    ids.push(qid)
    @save
      success: (model) ->
        console.log model
      error: (msg) ->
        alert msg
 
  parse: (response) ->
    response.question_ids = _.compact(response.question_ids.split(','))
    return response
 
  toJSON: ->
    attrs = _.clone @attributes
    attrs.question_ids = @get('question_ids').join()
    return _.omit(attrs, 'total_score')
  
  toViewJSON: ->
    attrs = _.clone @attributes
    
class SurveyBuilder.Collections.Surveys extends Backbone.Collection
  model: SurveyBuilder.Models.Survey
  url: '/surveys'