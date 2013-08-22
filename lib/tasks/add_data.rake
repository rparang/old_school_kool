namespace :db do
  desc "Fill database with reddit data from /r/oldschoolcool"
  task :populate => :environment do
    make_images
  end
end

def make_images
  require 'json'
  require 'open-uri'
  require 'fastimage'

  limit = 30
  url = "http://www.reddit.com/r/oldschoolcool.json?limit=#{limit}"

  puts "Fetching JSON..."
  results = JSON.parse(open(url).read)
  trimmed_results = results["data"]["children"]
  trimmed_results.each do |item|
    begin
      image_url = urlHelper(item["data"]["url"])
      unless (image_url == false)
        url = image_url
        dimensions = FastImage.size(url)
        width = dimensions[0]
        height = dimensions[1]
        aspect_ratio = width.to_f / height.to_f
        reddit_title = item["data"]["title"]
        reddit_author = item["data"]["author"]
        reddit_permalink = item["data"]["permalink"]
        reddit_thumbnail_url = item["data"]["thumbnail"]

        Image.create!(:url => url, :width => width, :height => height, :aspect_ratio => aspect_ratio, :reddit_title => reddit_title,
                      :reddit_author => reddit_author, :reddit_permalink => reddit_permalink, :reddit_thumbnail_url => reddit_thumbnail_url)
        puts "Saved first record..."  
      end
    rescue
      puts "Shit"
    end

  end
end

def urlHelper (url)
  urlEnd = url.split('.').last

  if (urlEnd == "jpg" || urlEnd == "png" || urlEnd == "gif")
    return url
  elsif (url.split('/')[2] == "imgur.com" && url.split('/')[3] != "gallery" && url.split('/')[3] != "a")
    urlNew = "http://i.imgur.com/" + url.split('/')[3] + ".jpg"
    return urlNew
  else
    return false
  end
    
end


