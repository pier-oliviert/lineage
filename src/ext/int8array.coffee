Int8Array::join = (arr, offset) ->
  for int, idx in arr
    @[offset + idx] = int
 
  arr.length
