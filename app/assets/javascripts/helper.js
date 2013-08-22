var Helper = {

  images: [],
  onload_count: 0,

  urlImageHelper: function (url) {
    urlEnd = url.split('.').pop();
    if (urlEnd == "jpg" || urlEnd == "png" || urlEnd == "gif") {
      return url;
    }
    else if (url.split('/')[2] == "imgur.com") {
      var urlNew = "http://i.imgur.com/" + url.split('/')[3] + ".jpg";
      return urlNew;
    }
    else {
      return false;
    }
  },

  imageLoad: function(item) {
    var image = new Image();
    image.onload = function() {
      Helper.onload_count += 1;
      var aspect_ratio = this.width / this.height;
      var obj = {
        url: this.src,
        aspect_ratio: aspect_ratio,
        width: this.width,
        height: this.height,
      };
      Helper.images.push(obj);
      //$('<img />').attr({"src": obj.url, "height": idealHeight, "id": onload_count, "data-ar": aspect_ratio}).appendTo("#images");
      if (Helper.onload_count == 18) {
        console.log("gooz");
        //testing2(images);
        //console.log(Helper.images);
        //return Helper.images;
      }
    };
    image.src = item;
  }


    
};
