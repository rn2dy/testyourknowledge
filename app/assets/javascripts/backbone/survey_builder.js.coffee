#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.SurveyBuilder =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Utils:
    shuffle: (ary) ->
      c = ary.length
      tmp
      idx
      while c > 0
        idx = (Math.random() * c--) | 0
        tmp = ary[c]
        ary[c] = ary[idx]
        ary[idx] = tmp
      return ary
            
    validateEmail: (email) ->
      re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      return re.test(email)
  
  API:    
    saveAllQuestionsUpdates: (jsonData) ->
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