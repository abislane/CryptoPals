require_relative 'challenge1.rb'
require_relative 'challenge3.rb'

if __FILE__ == $0
  in_file = File.new('input4.txt', 'r')

  best_ch2 = Float::INFINITY
  best_bytes = nil

  in_file.each_line do |line|
    bytes = Challenge1::hex_to_bytes(line)

    decoded = Challenge3::decode_single_xor(bytes)
    if decoded.score < best_ch2
      best_ch2 = decoded.score
      best_bytes = decoded.bytes
    end
  end

  puts best_bytes.pack('c*')
end