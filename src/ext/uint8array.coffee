Uint8Array::join = (arr, offset) ->
  for int in arr
    @[offset] = int
    offset++
  
  arr.length

Uint8Array::string = (callback) ->
  chars = []

  for byte in this
    break if byte is 0x00
    chars[_i] = String.fromCharCode byte

  callback(chars.join(""))

  this.subarray(++chars.length)

Uint8Array::int = (callback) ->
    callback(this[0])
    this.subarray(1)

Uint8Array::long = (callback) ->
    long = 0
    for byte in this.subarray(0,4)
      long |= byte << (8 * _i)

    callback(long)
    this.subarray(4)
