SurveyBuilder.Views.Questions ||= {}

class SurveyBuilder.Views.Questions.Question extends Backbone.View
  tagName: 'section'
  className: 'row builder-section'
  
  template: JST['backbone/templates/questions/question']
  answerTemplate: JST['backbone/templates/questions/answer']
  
  initialize: (options) ->
    @idx = options['idx']
      
  events:
    'blur textarea.title'       : 'saveTitle'
    'blur textarea.answer'      : 'saveAnswer'
    'blur input.score'          : 'saveScore'
    'click .add-answer button'  : 'addNewAnswer'
    'change input[type="radio"]': 'changeType'
    'click .marker-right'       : 'markAsRight'
    'click .marker-wrong'       : 'markAsWrong'
    'click .randomize'          : 'randomize'
    
  render: ->
    @$el.html @template(_.extend(@model.toJSON(), idx: @idx))
    return this
    
  saveTitle: (e) ->
    $title = $(e.currentTarget)
    if _.isEmpty($title.val())
      $title.val @model.get('title')
      return
    @model.set 'title', $title.val()
    
  saveAnswer: (e) ->
    $answer = $(e.currentTarget)
    if _.isEmpty($answer.val())
      $answer.val @model.get('answers')[$answer.data('bulletin')]
      return
    @model.setAnswers $answer.data('bulletin'), $answer.val()
  
  saveScore: (e) ->
    $score = $(e.currentTarget)
    score = parseInt $(e.currentTarget).val()
    if score == @model.get('score') || _.isEmpty($score.val())
      $score.val score
    else
      @model.set 'score', score
      
  addNewAnswer: ->
    new_bulletin = @model.nextBulletin()
    @model.setAnswers(new_bulletin, '')
    @render()
    
  changeType: (e) ->     
    type = $(e.currentTarget).val()
    @model.set { 'type' : type, 'correctness' : [] }
    @$('.marker-right').removeClass('badge-success')
    @$('.marker-wrong').addClass('badge-important')    
     
  markAsRight: (e) ->
    $marker = $(e.currentTarget)
    type = @model.get('type')
    if type == 's'
      @$('.marker-right').removeClass('badge-success')
      @$('.marker-wrong').addClass('badge-important')
    $marker.addClass('badge-success').next().removeClass('badge-important')
    if type == 's'
      correctness = []
    else
      correctness = _.clone @model.get('correctness')
    correctness.push $marker.prevAll('textarea').data('bulletin')
    @model.set 'correctness', _.uniq(correctness)
     
  markAsWrong: (e) ->
    $marker = $(e.currentTarget)
    $marker.addClass('badge-important').prev().removeClass('badge-success')
    correctness = _.clone(@model.get('correctness')) || []
    correctness = _.without(correctness, $marker.prevAll('textarea').data('bulletin'))    
    @model.set 'correctness', correctness
    
  randomize: ->
    randomized = SurveyBuilder.Utils.shuffle _.pairs(@model.get('answers'))        
    _correctness = []
    _answers = {}
    _.each randomized, (pair, idx) =>
      if _.indexOf(@model.get('correctness'), pair[0]) != -1
        _correctness.push String.fromCharCode(65 + idx)
      _answers[String.fromCharCode(65 + idx)] = pair[1]
      
    @model.set 'correctness', _correctness
    @model.set 'answers', _answers
    @render() 
     
       
     
     