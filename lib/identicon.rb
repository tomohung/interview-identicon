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
    NO_COLOR = ChunkyPNG::Color('white')
    BASIC_UNIT = 50 # pixels
    
    def initialize(user_name)
      md5 = Digest::MD5.new
      md5.update(user_name)
      @digest = md5.hexdigest.bytes
    end
    
    def generate
      color = get_color(@digest)
      puts color.inspect
      array = get_array(@digest)
      puts array.inspect
      png = get_png(array, color)
      png.save('filename.png', interlace: true)
    end

    private
      def get_color(digest)
        value = digest[0..3]
        ChunkyPNG::Color.rgba(value[0], value[1], value[2], value[3])
      end
      
      def get_array(digest)
        values = digest[16..31]
        col_count = COL / 2 + 1
        array = Hash.new
        
        count = 0
        ROW.times do |row|
          col_count.times do |col|
            color = values[count] % 2 == 0 ? 0 : 1
            array[[row,col]] = color 
            array[[row, COL - col - 1]] = color
            count += 1
            # DEBUG image is not correct, need to fix
          end
        end
        array
      end
      
      def get_png(array, color)
        png = ChunkyPNG::Image.new(250, 250, ChunkyPNG::Color::TRANSPARENT)

        array.each do |k, v|
          BASIC_UNIT.times do |row|
            BASIC_UNIT.times do |col|
              png[k[0] * BASIC_UNIT + row, k[1] * BASIC_UNIT + col] = v == 0 ? NO_COLOR : color
            end
          end
        end
        png
      end
  end
end