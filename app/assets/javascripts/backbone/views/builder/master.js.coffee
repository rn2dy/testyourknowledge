SurveyBuilder.Views.Builder ||= {}

class SurveyBuilder.Views.Builder.Master extends Backbone.View
  tagName: 'article'
  id: 'builder'
  template: JST['backbone/templates/builder/master']  
  
  initialize: ->
    @listenTo(@collection, 'change add', @refreshScore)
  
  events:
    'click #add-question button' : 'addQuestion'
    'click .publish'             : 'publishSurvey'    
    
  render: ->    
    @$el.html @template(@model.toViewJSON())
    @renderQuestions()
    @startAutoSave()
    return this

  renderQuestions: ->
    @collection.each (question, index) =>
      question_view = new SurveyBuilder.Views.Questions.Question({ model: question, idx: index + 1 })
      @$('#questions').append question_view.render().el

  refreshScore: ->
    total_score = @collection.reduce (sum, model) -> 
      return sum + parseInt(model.get('score'))
    ,0
    @$('.total-score').text(total_score)
    
  addQuestion: ->
    # clearInterval 
    clearInterval @autoSave
    question = new SurveyBuilder.Models.Question()
    
    question.save null,
      success: (q) =>
        @model.addNewQuestion(q.get('id') + '')
        question_view = new SurveyBuilder.Views.Questions.Question({model: q, idx: @collection.length + 1 })
        @collection.add q        
        @$('#questions').append question_view.render().el
        @startAutoSave()                       
        # clear changed attribtues, so that AutoSave will not pick this up a again
        q.changed = {}
      error: ->
        alert 'Failed create new questions!'      
      
   
  startAutoSave: ->     
    $runner = @$('.runner')
    @autoSave = setInterval =>
      $runner.show()
      setTimeout ->
        $runner.hide()
      , 1000                                  
       
      models = @collection.filter (q) -> q.hasChanged()
      # clear changed attribtues
      @collection.each (q) -> q.changed = {}
      if models.length > 0
        jsonData = _.map models, (q) -> q.toJSON()
       
        $.ajax
          type: 'POST'
          dataType: 'json'
          contentType: 'application/json'
          url: '/questions/save_all'
          data: JSON.stringify { questions: jsonData }
          success: (data) ->
            console.log data
          error: (jqXHR, textStatus, errorThrown) ->
            console.log textStatus, errorThrown
       else
         console.log 'un-modified'
                          
    , 10*1000
       
     # $.ajax({
     #   type: 'POST',
     #   dataType: 'json',
     #   contentType: 'application/json',
     #   url: '/questions/save_all',
     #   data: JSON.stringify(questions: tc.toJSON()),
     #   success: function(data){ console.log(data) },
     #   error: function(jqXHR, textStatus, errorThrown) { console.log(textStatus, errorThrown) }     
     # });
      
  publishSurvey: ->
    model = new SurveyBuilder.Models.PublishedSurvey({survey_id: @model.get('id')})
    view = new SurveyBuilder.Views.Builder.PublisherModal({model: model}) 
    @$('#builder-form').after view.render().el
    $('#publisher-modal').modal()