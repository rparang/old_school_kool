class OldSchoolCool.Routers.Images extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    @collection = new OldSchoolCool.Collections.Images()
    @collection.fetch
      success: (collection) ->
        view = new OldSchoolCool.Views.ImagesIndex(collection: collection)
        $('#container').html(view.render().el)