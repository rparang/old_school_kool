window.OldSchoolCool =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new OldSchoolCool.Routers.Images()
    Backbone.history.start(pushStart: true)

$(document).ready ->
  OldSchoolCool.initialize()
