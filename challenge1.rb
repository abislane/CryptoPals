require 'base64'

module Challenge1
  def self.hex_to_bytes(str)
    str.scan(/../).map(&:hex)
  end

  def self.bytes_to_hex(arr)
    arr.map { |byte| byte >= 16 ? byte.to_s(16) : '0' + byte.to_s(16)}.join
  end

  def self.bytes_to_base64(arr)
    Base64.strict_encode64(arr.pack('c*'))
  end

  def self.base64_to_bytes(str)
    Base64.decode64(str).each_byte.to_a
  end
end

if __FILE__ == $0
  input = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'

  puts 'Converting to base 64'
  b64 = Challenge1::bytes_to_base64(Challenge1::hex_to_bytes(input))
  puts 'Expected: ' + 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'
  puts 'Obtained: ' + b64

  puts 'Converting back to hex'
  hex = Challenge1::bytes_to_hex(Challenge1::base64_to_bytes(b64))
  puts 'Expected: ' + '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
  puts 'Obtained: ' + hex
end