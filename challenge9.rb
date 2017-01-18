
module Challenge9
  def self.pkcs7_padding(str, n)
    c = n - str.size
    for i in (0...c) do
      str += c.chr
    end

    str
  end
end

if __FILE__ == $0
  str = "YELLOW SUBMARINE"
  padded = Challenge9::pkcs7_padding(str, 20)
  puts padded
  p padded.each_byte.to_a
end