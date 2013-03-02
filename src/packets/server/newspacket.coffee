chrome.app.Routes[66] = class NewsPacket
  id: 66
  constructor: (@data) ->
    @data = @data.string(@message)

  message: =>
    return @_message if arguments.length is 0
    @_message = arguments[0]

PacketId.News = 63
