require "identicon/version"
require "chunky_png"
require "digest"

module Identicon
  def self.new(user_name)
    Icon.new(user_name)
  end

  class Icon
    ROW = 5
    COL = 5
    BASIC_UNIT = 50 # pixels
    
    def initialize(user_name)
      md5 = Digest::MD5.new
      md5.update(user_name)
      @username = user_name
      @digest = md5.hexdigest.bytes
    end
    
    def generate
      puts @digest.inspect
      color = get_color(@digest)
      puts color.inspect
      array = get_array(@digest)
      puts array.inspect
      png = get_png(array, color)
      png.save("#{@username}.png", interlace: true)
    end

    private
      def get_color(digest)
        value = digest[0..3]
        ChunkyPNG::Color.rgba(value[0], value[1], value[2], value[3])
      end
      
      def get_array(digest)
        values = digest[16..31]
        row_count = ROW / 2 + 1
        array = Hash.new
        
        count = 0
        COL.times do |col|
          row_count.times do |row|
            color = values[count] % 2 == 0 ? 0 : 1
            array[[row, col]] = color 
            array[[ROW - row - 1, col]] = color
            count += 1
          end
        end
        array
      end
      
      def get_png(array, color)
        png = ChunkyPNG::Image.new(250, 250, ChunkyPNG::Color::TRANSPARENT)

        array.each do |k, v|
          next if v == 0
          BASIC_UNIT.times do |row|
            BASIC_UNIT.times do |col|
              png[k[0] * BASIC_UNIT + row, k[1] * BASIC_UNIT + col] = color
            end
          end
        end
        png
      end
  end
end