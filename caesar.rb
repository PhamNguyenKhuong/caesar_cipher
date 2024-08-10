
def caesar_cipher(string, num)
  string.bytes.map do |char|
    if char.between?(97, 122) 
      (((char + num - 97) % 26) + 97).chr 
    elsif char.between?(65, 90)
      (((char + num - 65) % 26) + 65).chr
    else
      char.chr
    end 
  end.join
end

puts caesar_cipher("Hello world", 5)