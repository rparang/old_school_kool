class OldSchoolCool.Collections.Images extends Backbone.Collection
  url: '/api/images'
  model: OldSchoolCool.Models.Image

  getElement: ->
    return @currentElement

  setElement: (model) ->
    @currentElement = model

  next: ->
    @setElement(@at(@indexOf(@getElement()) + 1 ))
    return this

  prev: ->
    @setElement(@at(@indexOf(@getElement()) - 1 ))
    return this

  getIndex: ->
    return @indexOf(@getElement())