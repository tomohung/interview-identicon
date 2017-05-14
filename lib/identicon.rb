require "identicon/version"

class Identicon
  
  def initialize(user_name)
    md5 = Digest::MD5.new
    md5.update(user_name)
    @digest = md5.hexdigest
  end
  
  def generate
    color = get_color(@digest)
    array = get_array(@digest)
    png = get_png(array, color)
    png.save('filename.png', interlace: true)
  end

  private
    def get_color(digest)
    end
    
    def get_array(digest)
    end
    
    def get_png(array, color)
    end
end