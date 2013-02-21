Uint8Array::join = (arr, offset) ->
  for int in arr
    @[offset] = int
    offset++

