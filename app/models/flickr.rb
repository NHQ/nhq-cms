class Flickr
  include Mongoid::Document

  embedded_in :show, :inverse_of => :flickrs
  # embedded_in :workshop
  # embedded_in :event

  class << self   # begin class methods
  
    def fetch_photoset_list
      photosets_list = flickr.photosets.getList(:user_id => '49951737@N02').to_a
      photosets_list.each do |photoset|
        p = photoset.to_hash

        # get photos
        phs = flickr.photosets.getPhotos(:photoset_id => p["id"]).to_hash["photo"]
      
        # get photo ids
        photos = phs.map {|photo| photo["id"]}
      
        # select primary photo
        primary_photo = phs.select {|pp| pp["isprimary"] == "1"}.first || phs.first
      
        # get primary photo information
        pp_info = flickr.photos.getInfo(:photo_id => primary_photo["id"]).to_hash
      
        primary_photo_url = "http://farm#{pp_info["farm"]}.static.flickr.com/#{pp_info["server"]}/#{pp_info["id"]}_#{pp_info["secret"]}_t.jpg"
        p = photoset.to_hash.merge({:user_content => nil, 
                                    :type => "flickr photoset",
                                    :photos => photos,
                                    :primary_photo => primary_photo["id"],
                                    :primary_photo_url => primary_photo_url,
                                    :photoset_id => p["id"],
                                    :id => nil
                                  })

        f = Flickr.first(:conditions => { :photoset_id => p["id"]})
        if f
          f.update_attributes(p)
        else
          f = Flickr.new(p)
          f.save
        end
      end
    end

  end  # end class methods

end