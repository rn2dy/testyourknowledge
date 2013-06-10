class Questions.Models.Survey extends Backbone.Model
  paramRoot: 'survey'
  urlRoot: '/surveys'
  
  defautls:
    name: null
    description: null
    
    
class Questions.Models.Surveys extends Backbone.Collection
  model: Questions.Models.Survey
  url: '/surveys'