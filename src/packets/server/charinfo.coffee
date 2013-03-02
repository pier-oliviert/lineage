chrome.app.Routes[102] = class CharInfoPacket
  id: 102
  constructor: (@data) ->
    @data = @data.string(@name)
    @data = @data.string(@pledge)

  name: =>
    return @_name if arguments.length is 0
    @_name = arguments[0]

  pledge: =>
    return @_pledge if arguments.length is 0
    @_pledge = arguments[0]

PacketId.CharInfo = 102
