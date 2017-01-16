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
    total = 0
    size = str.size / key_length - 1
    for i in (0...size)
      total += hamming_distance(str[i*key_length...(i+1)*key_length], str[(i+1)*key_length...(i+2)*key_length])
    end

    total / (1.0 * size * key_length)
  end

  def self.decrypt_repeated_xor(bytes, key_length)
    blocks = get_blocks(bytes, key_length)
    key = ''
    decrypted_blocks = []

    blocks.each do |block|
      decoded = Challenge3::decode_single_xor(block)
      decrypted_blocks.push(decoded.bytes)
      if decoded.bytes.nil?
        return
      end
      #puts 'key for block :' + decoded.key.to_s
      key += decoded.key.chr
    end

    result = OpenStruct.new
    result.bytes = compose_blocks(decrypted_blocks)
    result.key = key
    result
  end

  def self.get_blocks(bytes, key_length)
    result = []
    for i in (0...key_length)
      result.push([])
    end

    bytes.each_with_index do |byte, i|
      result[i % key_length].push(byte)
    end

    result
  end

  def self.compose_blocks(blocks)
    result = []
    for i in (0...blocks[0].size)
      for j in (0...blocks.size)
        if i < blocks[j].size
          result.push(blocks[j][i])
        end
      end
    end

    result
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

  for key_length in (2..40) do
    found_dist = Challenge6::aggregate_hamming_dist(input, key_length)
    
    if found_dist < 3
      possible_result = Challenge6::decrypt_repeated_xor(in_bytes, key_length)
      unless possible_result.nil?
        puts 'KEY: ' + possible_result.key
        puts 'MESSAGE:'
        puts possible_result.bytes.pack('c*')
        break
      end
    end
  end
end