require_relative 'challenge1.rb'
require 'set'

module Challenge8
  def self.get_blocks(str)
    blocks = []
    size = str.size / 16
    for i in (0...size)
      blocks.push(str[i*16, 16])
    end

    blocks
  end

  def self.is_ECB(str)
    blocks = get_blocks(str)
    
    for b1 in (0...blocks.size) do
      for b2 in (0...b1) do
        if blocks[b1] == blocks[b2]
          return true
        end
      end
    end

    false
  end
end

if __FILE__ == $0
  in_file = File.new('input8.txt', 'r')

  line_num = 1
  in_file.each_line do |line|
    str = Challenge1::hex_to_bytes(line).pack('c*')
    if Challenge8::is_ECB(str)
      print 'found ECB on line #' + line_num.to_s
      #puts str
      break
    end
    line_num += 1
  end
end