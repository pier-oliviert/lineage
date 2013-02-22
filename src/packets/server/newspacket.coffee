class @NewsPacket
  constructor: (data) ->

    @message = @convertByteToChar(data).join("")


  convertByteToChar: (bytes) ->
    chars = []

    for byte in bytes
      chars[_i] = String.fromCharCode byte
