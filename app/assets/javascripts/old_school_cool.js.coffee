window.OldSchoolCool =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new OldSchoolCool.Routers.Images()
    Backbone.history.start(pushState: true)

$(document).ready ->
  OldSchoolCool.initialize()
