class OldSchoolCool.Views.Show extends Backbone.View

  template: JST['images/show']

  id: 'show'

  events:
    'click #next': 'nextImage'
    'click #prev': 'prevImage'

  initialize: ->
    _.bindAll(this);
    $(document).bind('keydown', @keyHandler);

  render: ->
    $(@el).html(@template({ collection: this.options.collection, image: @model }))
    return this

  nextImage: (e) ->
    e.preventDefault() #Prevent Chrome bug and click event clashing
    this.options.collection.next()
    Backbone.history.navigate("i/#{this.options.collection.getElement().get('id')}", true)

  prevImage: (e) ->
    e.preventDefault()
    this.options.collection.prev()
    Backbone.history.navigate("i/#{this.options.collection.getElement().get('id')}", true)

  keyHandler: (e) ->
    @collection = this.options.collection
    #console.log(e.keyCode)
    if e.keyCode == 39 && @collection.getIndex(@collection.getElement()) < @collection.length - 1
      this.nextImage(e)
      this.remove()
    if e.keyCode == 37 && @collection.getIndex(@collection.getElement()) > 0
      this.prevImage(e)
      this.remove()
    if e.keyCode == 27
      Backbone.history.navigate("/", true)
      this.remove()

  remove: ->
    $(document).off('keydown', @keyHandler)
    Backbone.View.prototype.remove.call(this);