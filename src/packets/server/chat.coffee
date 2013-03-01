class ChatPacket
  id: [3, 47, 71]
  constructor: (data) ->
    @data(data)
    @type = @int @data()
    switch @type
      when 0
        @id = 71
        @cid = @long @data()
      when 3 then @id = 3
    @message = @string @data()

  data: ->
    return @bytes if arguments.length is 0
    @bytes = arguments[0]

  int: (data) ->
    integer = data[0]
    @data data.subarray(1)
    integer

  long: (data) ->
    long = 0
    for byte in data.subarray(0,4)
      long |= byte << (8 * _i)

    @data data.subarray(4)
    console.log long
    long

  string: (data) ->
    chars = []

    for byte in data
      break if byte is 0x00
      chars[_i] = String.fromCharCode byte

    @data data.subarray(++chars.length)

    chars.join("")

chrome.app.Routes[3] = chrome.app.Routes[47] = chrome.app.Routes[71] = ChatPacket

PacketId.GlobalChat = 3
PacketId.WhisperChat = 47
PacketId.Chat = 71
