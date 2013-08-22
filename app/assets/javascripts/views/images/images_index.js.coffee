class OldSchoolCool.Views.ImagesIndex extends Backbone.View

  template: JST['images/index']

  initialize: ->
    #$(window).on('resize.app', this.render, this)
    $(window).bind("resize.app", _.bind(this.render, this))

  remove: ->
    $(window).unbind("resize.app");
    Backbone.View.prototype.remove.call(this);

  
  calculate: (collection) ->
    _this = this

    #Need cushion for browser window
    buffer_margin = 38

    #Find browser window width and subtract buffer margin
    viewport_width = $(window).width() - buffer_margin

    #Ideal height is roughly half the window height
    ideal_height = $(window).height() / 2

    summed_width = 0

    collection.each (image)  ->
      summed_width += image.get('aspect_ratio') * ideal_height

    #Number of rows of images
    rows = Math.round(summed_width / viewport_width)

    if rows < 1
      #Fall back to standard size
      collection.each (image) ->
        height = parseInt(ideal_height * image.get('aspect_ratio'))
        width = ideal_height
        view = new OldSchoolCool.Views.Image({model: image, width: width, height: height})
        _this.$('#image-wrapper').append(view.render().el)
    else
      #Find number of photos per row using algorithm
      weights = collection.map (p) -> parseInt(p.get('aspect_ratio') * 100)
      partition = @linear_partition(weights, rows)
      console.log(partition)

      #Sum aspect ratios for each row as distribution
      #and multiply each width by photo aspect ratio to maintain proportion
      index = 0
      row_buffer = new Backbone.Collection
      $.each partition, (key, row) ->
        total_width = 0 #DELETE
        summed_ratios = 0
        row_buffer.reset()
        $.each row, ->
          row_buffer.add(collection.at(index))
          index = index + 1
        row_buffer.each (image) ->
          summed_ratios = summed_ratios + Number(image.get('aspect_ratio'))
        console.log("summed ratios is " + summed_ratios)
        row_buffer.each (image) ->
          width = parseInt(viewport_width / summed_ratios * image.get('aspect_ratio'))
          height = parseInt(viewport_width / summed_ratios)
          total_width = total_width + width
          view = new OldSchoolCool.Views.Image({model: image, width: width, height: height})
          _this.$('#image-wrapper').append(view.render().el)
        console.log("total width is " + total_width)

  render: ->
    $(@el).html(@template())
    #this.el = $(this.template())
    @calculate(@collection, this)
    console.log("fired")
    #@collection.each(@appendImage, this)
    this

  appendImage: (image) ->
    view = new OldSchoolCool.Views.Image(model: image)
    #this.$('#image-wrapper').append(view.render().el)
    this.$('#image-wrapper').append("<p>gooz!</p>")

  linear_partition: (seq, k) ->
    n = seq.length
    
    return [] if k <= 0
    return seq.map((x) -> [x]) if k > n
   
    table = (0 for x in [0...k] for y in [0...n])
    solution = (0 for x in [0...k-1] for y in [0...n-1])
    table[i][0] = seq[i] + (if i then table[i-1][0] else 0) for i in [0...n]
    table[0][j] = seq[0] for j in [0...k]
    for i in [1...n]
      for j in [1...k]
        m = _.min(([_.max([table[x][j-1], table[i][0]-table[x][0]]), x] for x in [0...i]), (o) -> o[0])
        table[i][j] = m[0]
        solution[i-1][j-1] = m[1]
   
    n = n-1
    k = k-2
    ans = []
    while k >= 0
      ans = [seq[i] for i in [(solution[n-1][k]+1)...n+1]].concat ans
      n = solution[n-1][k]
      k = k-1
   
    [seq[i] for i in [0...n+1]].concat ans
