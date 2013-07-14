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
      @saveAllUpdates()                          
    , 10*1000
  
  saveAllUpdates: -> 
    models = @collection.filter (q) -> q.hasChanged()    
    @collection.each (q) -> q.changed = {}
    if models.length > 0
      jsonData = _.map models, (q) -> q.toJSON()      
      SurveyBuilder.API.saveAllQuestionsUpdates jsonData      
    else
      console.log 'un-modified'
      
  publishSurvey: ->
    # validate input first
    $('[class*="errmsg"]').hide().empty()
    
    if msg = @validateSurvey()
      anchors = []
      _.each _.keys(msg), (k) ->
        $ul = $('<ul>')
        _.each msg[k], (errmsg) -> $ul.append("<li>#{errmsg}</li>")
        $('.errmsg-' + k).append($ul).show()                       
        anchors.push ".errmsg-#{k}"
        
      # scroll to error msg      
      $(anchors[0])[0].scrollIntoView()
      
    else
      clearInterval @autoSave
      @saveAllUpdates()
      model = new SurveyBuilder.Models.PublishedSurvey({survey_id: @model.get('id')})
      view = new SurveyBuilder.Views.Builder.PublisherModal({model: model}) 
      @$('#builder-form').after view.render().el
      $('#publisher-modal').modal()
   
  validateSurvey: ->
    # 1. make sure every question has a correct answer
    # 2. make sure there is no empty questions and answers 
    msg = {}                       
    
    @collection.each (q, idx) ->
      key = "#{idx+1}"
      title = q.get('title')
      answers = q.get('answers')
      correctness = q.get('correctness')
      errTit = /^\s*$/.test(title)
      errAns = _.contains(_.values(answers), '')
      errCorr= correctness.length == 0
      if errAns || errCorr
        msg[key] = []
        msg[key].push "Empty question body." if errTit
        msg[key].push "Empty answers." if errAns
        msg[key].push "You must mark some answers as correct." if errCorr        

    return null if _.isEmpty(msg)
    return msg
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      