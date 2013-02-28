Int8Array::join = (arr, offset = 0) ->
  for int, idx in arr
    @[offset + idx] = int
 
  arr.length
