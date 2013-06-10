class Questions.Routers.AppRouter extends Backbone.Router
  routes:
    "" : "builder"
    
  builder: ->
    alert "in builder"