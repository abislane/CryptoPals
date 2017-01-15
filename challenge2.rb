require_relative 'challenge1.rb'

module Challenge2
  def self.fixed_xor(arr1, arr2)
    arr1.each_with_index.map { |e, i| e ^ arr2[i] }
  end
end

if __FILE__ == $0
  include Challenge1

  in1 = '1c0111001f010100061a024b53535009181c'
  in2 = '686974207468652062756c6c277320657965'

  arr1 = Challenge1::hex_to_bytes(in1)
  arr2 = Challenge1::hex_to_bytes(in2)

  result_bytes = Challenge2::fixed_xor(arr1, arr2)
  result = Challenge1::bytes_to_hex(result_bytes)

  puts 'Expected: ' + '746865206b696420646f6e277420706c6179'
  puts 'Obtained: ' + result
end
