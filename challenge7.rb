require 'openssl'
require_relative 'challenge1.rb'

module Challenge7
  def self.encrypt_ECB(str, key)
    cipher = OpenSSL::Cipher::AES.new(128, :ECB)
    cipher.encrypt
    cipher.padding = 0
    cipher.key = key

    cipher.update(str)
  end

  def self.decrypt_ECB(str, key)
    cipher = OpenSSL::Cipher::AES.new(128, :ECB)
    cipher.decrypt
    cipher.padding = 0
    cipher.key = key

    cipher.update(str)
  end
end

if __FILE__ == $0
  input_file = File.new('input7.txt', 'r')
  input = ''
  input_file.each_line do |line|
    input += line
  end

  key = 'YELLOW SUBMARINE'

  encrypted = Challenge1::base64_to_bytes(input).pack('c*')

  puts Challenge7::decrypt_ECB(encrypted, key)
end