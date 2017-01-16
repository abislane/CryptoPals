require 'openssl'
require_relative 'challenge1.rb'

if __FILE__ == $0
  input_file = File.new('input7.txt', 'r')
  input = ''
  input_file.each_line do |line|
    input += line
  end

  encrypted = Challenge1::base64_to_bytes(input).pack('c*')

  cipher = OpenSSL::Cipher::AES.new(128, :ECB)
  cipher.decrypt
  cipher.key = "YELLOW SUBMARINE"

  plain = cipher.update(encrypted) + cipher.final
  puts plain
end