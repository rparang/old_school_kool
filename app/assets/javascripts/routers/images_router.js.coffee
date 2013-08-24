class OldSchoolCool.Routers.Images extends Backbone.Router
  routes:
    '': 'index'
    'i/:id': 'show'

  index: ->
    _this = this

    # See if we already have a collection
    @collection = this.getCollection()

    if @collection?
      view = new OldSchoolCool.Views.ImagesIndex(collection: @collection)
      $('#container').html(view.render().el)
    else
      @collection = new OldSchoolCool.Collections.Images()
      @collection.fetch
        success: (collection) ->

          # Store collection so we can reference it later
          # and avoid additional server calls
          _this.setCollection(collection)
          view = new OldSchoolCool.Views.ImagesIndex(collection: collection)
          $('#container').html(view.render().el)

  show: (id) ->
    _this = this

    # See if we already have a collection
    @collection = this.getCollection()

    # Already have collection and model after index load
    # and no need to fetch
    if @collection?
      @model = @collection.get(id)

      # Set collection model reference to know where we are
      @collection.setElement(@model)
      view = new OldSchoolCool.Views.Show({ collection: @collection, model: @model })
      $('#container').html(view.render().el)

    # Need to fetch collection because image was requested
    # directly
    else
      @collection = new OldSchoolCool.Collections.Images()
      @collection.fetch
        success: (collection) ->
          @model = collection.get(id)

          # Set collection model reference to know where we are
          collection.setElement(@model)

          # Store collection so we can reference it later
          # and avoid additional server calls
          _this.setCollection(collection)
          view = new OldSchoolCool.Views.Show({ collection: collection, model: @model })
          $('#container').html(view.render().el)

  getCollection: ->
    return @currentCollection

  setCollection: (lot) ->
    @currentCollection = lot