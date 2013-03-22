Uint8Array::join = (arr, offset) ->
  for int in arr
    @[offset] = int
    offset++
  
  arr.length

Uint8Array::string = ->
  chars = []

  for byte in this
    break if byte is 0x00
    chars[_i] = String.fromCharCode byte

  {value: chars.join(""), size: ++chars.length}

Uint8Array::int = (size) ->
  value = 0
  for byte in this.subarray(0,size)
    value |= byte << 8 * _i

  {value: value, size: size}

Uint8Array::int8 = ->
  @int(1)

Uint8Array::int16 = ->
  @int(2)

Uint8Array::int32 = ->
  @int(4)

Uint8Array::int64 = ->
  @int(8)

Uint8Array::parse = (packet, map) ->
  data = new Uint8Array this
  for key, type of map
    obj = data[type].call(data)
    packet[key].call(packet, obj.value)
    data = data.subarray(obj.size)

