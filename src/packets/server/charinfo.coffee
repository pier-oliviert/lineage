chrome.app.Routes[102] = class CharInfoPacket
  id: 102
  constructor: (data) ->
    @data(data)
    @name = @string @data()
    @pledge = @string @data()


  data: ->
    return @bytes if arguments.length is 0
    @bytes = arguments[0]

  string: (data) ->
    chars = []

    for byte in data
      break if byte is 0x00
      chars[_i] = String.fromCharCode byte

    @data data.subarray(++chars.length)

    chars.join("")

PacketId.CharInfo = 102
