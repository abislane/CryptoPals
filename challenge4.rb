require_relative 'challenge1.rb'
require_relative 'challenge3.rb'

if __FILE__ == $0
  in_file = File.new('input4.txt', 'r')

  best_ch2 = Float::INFINITY
  best_bytes = nil

  in_file.each_line do |line|
    bytes = Challenge1::hex_to_bytes(line)

    for key in (0...256) do
      decoded = Challenge3::single_xor(bytes, key)
      score = Challenge3::get_chi_sq(decoded)

      if score < best_ch2
        best_ch2 = score
        best_bytes = decoded
      end
    end
  end

  puts best_bytes.pack('c*')
end