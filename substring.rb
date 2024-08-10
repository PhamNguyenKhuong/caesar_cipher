def substrings(string, list) 
  result = Hash.new()
  list.each { |word| 
    copies = string.downcase.scan(word.downcase).length
    result[word] = copies if copies > 0
  }
  result
end