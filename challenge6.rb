require_relative 'challenge1.rb'
require_relative 'Challenge5.rb'
require_relative 'challenge3.rb'

module Challenge6
  def self.byte_hamming_distance(byte1, byte2)
    result = 0
    xor = byte1 ^ byte2

    until xor == 0
      result += xor % 2
      xor /= 2
    end

    result
  end

  def self.hamming_distance(str1, str2)
    bytes1 = str1.each_byte.to_a
    bytes2 = str2.each_byte.to_a

    result = 0
    for i in (0...bytes1.size) do
      result += byte_hamming_distance(bytes1[i], bytes2[i])
    end

    result
  end

  def self.aggregate_hamming_dist(str, key_length)
    substrings = []
    for i in (0...6)
      substrings.push(str[i*key_length...(i+1)*key_length])
    end

    total = 0
    for i in (0...6)
      for j in (i+1...6)
        total += hamming_distance(substrings[i], substrings[j])
      end
    end

    total / (1.0 * key_length)
  end
end

if __FILE__ == $0
  include Challenge1
  include Challenge5

  in_file = File.new('input6.txt', 'r')
  input = ''
  in_file.each_line do |line|
    input += line
  end

  in_bytes = Challenge1::base64_to_bytes(input)

  k = 0
  min_ham_dist = Float::INFINITY
  for key_length in (2..40) do
    found_dist = Challenge6::aggregate_hamming_dist(input, key_length)
    if(found_dist < min_ham_dist)
      k = key_length
      min_ham_dist = found_dist
    end
  end

  puts 'verified key length of ' + k.to_s
end