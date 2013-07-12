class SurveyBuilder.Models.PublishedSurvey extends Backbone.Model
  urlRoot: '/published_surveys'

  defaults:
    'id' : null
    
  validate: (attrs, options) ->
    email = attrs.email
    confirm = attrs.email_confirm
    # not blank
    # must equal
    # is email
    if !email || /^\s*$/.test(email) || !confirm || /^\s*$/.test(confirm)
      return 'Blank input!'
    if email != confirm
      return 'The email addresses do not match!'
    if !SurveyBuilder.Utils.validateEmail(confirm)
      return 'Invalid email!'
      
class SurveyBuilder.Collections.PublishedSurveys extends Backbone.Collection
  model: SurveyBuilder.Models.PublishedSurvey
  url: '/published_surveys'