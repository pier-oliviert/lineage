chrome.app.Routes[102] = class CharInfoPacket
  id: 102
  constructor: (@data) ->
    @data.parse(this,
      name: "string",
      pledge: "string"
    )

  name: (name) ->
    return @_name if arguments.length is 0
    @_name = name

  pledge: (pledge) ->
    return @_pledge if arguments.length is 0
    @_pledge = pledge

PacketId.CharInfo = 102
