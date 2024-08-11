def sort array
  for i in 0..(array.length - 3)
    for j in 0..(array.length - 2 - i)
      if array[j] > array[j + 1]
        array[j], array[j + 1] = array[j + 1], array[j]
      end
    end
  end
  array
end

p sort([4,3,78,2,0,2])