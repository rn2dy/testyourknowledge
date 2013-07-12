class SurveyBuilder.Models.Question extends Backbone.Model
  # paramRoot: 'question'
  urlRoot: '/questions'
     
  defaults:
    title: ''
    score: 2
    type: 's'
    answers: {'A' : '', 'B' : ''}
    correctness: []
  
  setAnswers: (bulletin, body) ->
    answers = _.clone @get('answers')
    answers[bulletin] = body
    @set 'answers', answers
  
  nextBulletin: ->
    c = _.max(_.keys(@get('answers')), (item) -> return item.charCodeAt(0))
    String.fromCharCode (c.charCodeAt(0) + 1)
      
class SurveyBuilder.Collections.Questions extends Backbone.Collection
  model: SurveyBuilder.Models.Question
  url: '/questions'