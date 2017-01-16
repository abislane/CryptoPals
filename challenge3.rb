
require_relative 'challenge1.rb'
require 'ostruct'

module Challenge3
  @@english_freq = [
    0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, # A-G
    0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, # H-N
    0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, # O-U
    0.00978, 0.02360, 0.00150, 0.01974, 0.00074                    # V-Z
  ]

  def self.get_chi_sq(bytes)
    count = Array.new(26, 0)
    ignored = 0
    spaces = 0

    bytes.each do |char|
      if char >= 65 and char <= 90  # uppercase A-Z
        count[65 - char] += 1
      elsif char >= 97 and char <= 122 # lowercase a-z
        count[char - 97] += 1
      elsif char == 32
        spaces += 1
      elsif char >= 33 and char <= 126 # punctuation
        ignored += 1
      elsif char == 9 or char == 10 or char == 13 # whitespace
        ignored += 1
      else #non-printible ASCII
        return Float::INFINITY
      end
    end

    chi2 = 0
    len = bytes.size - ignored
    
    if spaces < 3
      return Float::INFINITY
    end

    for i in (0...26) do
      observed = count[i]
      expected = len * @@english_freq[i]
      diff = observed - expected
      chi2 += diff*diff / expected
    end

    chi2
  end

  def self.single_xor(arr, key)
    arr.map { |byte| byte ^ key }
  end

  def self.decode_single_xor(bytes)
    best_ch2 = Float::INFINITY
    best_bytes = nil

    for key in (0...256) do 
      decoded = single_xor(bytes, key)
      score = get_chi_sq(decoded)

      if score < best_ch2
        best_ch2 = score
        best_bytes = decoded
      end
    end

    result = OpenStruct.new
    result.bytes = best_bytes
    result.score = best_ch2

    result
  end
end

if __FILE__ == $0
  include Challenge1

  input = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
  in_bytes = Challenge1::hex_to_bytes(input)

  result = Challenge3::decode_single_xor(in_bytes)

  puts result.bytes.pack('c*')
end
