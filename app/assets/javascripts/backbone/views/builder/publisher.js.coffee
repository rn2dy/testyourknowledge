class SurveyBuilder.Views.Builder.PublisherModal extends Backbone.View
  tagName: 'section'
  id: 'publisher-modal'
  className: 'modal hide fade'
    
  template: JST['backbone/templates/builder/publisher_modal']
  
  initialize: ->
    @listenTo @model, 'invalid', @renderError
    @listenTo @model, 'change:id', @renderURL
    
  events:
    'click .register-email' : 'registerEmail'
    
  render: ->
    @$el.html @template(@model.toJSON())  
    return this                            
  
  renderError: ->
    @$('.alert-error').text(@model.validationError).show()
    @lada.stop()
    
  renderURL: ->
    @render()                           
    @setupClipboard()
    @lada.stop()
  
  toJSON: ->
    attrs = _.clone @attributes
    _.omit attrs, 'email_confirm'
    return attrs
    
  registerEmail: ->
    @lada = Ladda.create document.querySelector('.register-email')
    @lada.start()
    @model.set { email: @$('input#email').val(), email_confirm: @$('input#email-confirm').val() }
    @model.save()
        
  setupClipboard: ->    
    clip = new ZeroClipboard(@$('#copy-btn'), { moviePath: window.clipboard })
    clip.on 'complete', (client, args) ->
      $('#copy-btn').text('copied')
    