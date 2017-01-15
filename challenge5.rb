require_relative 'challenge1.rb'

module Challenge5
  def self.repeated_xor(bytes, key)
    bytes.each_with_index.map { |byte, index| byte ^ key[index % key.size] }
  end
end

if __FILE__ == $0
  include Challenge1
  input = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal".each_byte.to_a
  key = "ICE".each_byte.to_a
  encoded = Challenge5::repeated_xor(input, key)

  result = Challenge1::bytes_to_hex(encoded)

  puts 'Expected : 0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f'
  puts 'Obtained : ' + result
end