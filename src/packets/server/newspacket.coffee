chrome.app.Routes[66] = class NewsPacket
  id: 66
  constructor: (data) ->

    @message = @convertByteToChar(data).join("")


  convertByteToChar: (bytes) ->
    chars = []

    for byte in bytes
      break if byte is 0x00
      chars[_i] = String.fromCharCode byte

PacketId.News = 63
