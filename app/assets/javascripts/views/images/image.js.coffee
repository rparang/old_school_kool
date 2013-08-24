class OldSchoolCool.Views.Image extends Backbone.View
  
  events:
    'click': 'showImage'

  template: JST['images/image']

  render: ->
    $(@el).html(@template({ model: @model, width: parseInt(this.options.width), height: parseInt(this.options.height) }))
    #@el = $(this.template({ model: @model, width: parseInt(this.options.width), height: parseInt(this.options.height) }))
    this

  showImage: ->
    Backbone.history.navigate("i/#{@model.get('id')}", true)