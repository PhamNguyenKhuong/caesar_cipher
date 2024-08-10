def stock_picker(list)
  list.each_with_index.to_a.combination(2).max_by{|buy, sell| sell[0] - buy[0]}.map{|price, i| i}
end