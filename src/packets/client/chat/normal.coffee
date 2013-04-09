chrome.app.Packets.Chat.Normal = class ChatPacket extends Packet
  types:
    normal: 0
    shouting: 2
    clan: 4

  constructor: ->
    super 18, ["message", "type"]

  message: ->
    return if arguments.length is 0
    @process arguments[0], "message"

  type: ->
    return if arguments.length is 0
    type = @types[arguments[0]]
    @packed "type", type && 0xFF

  length: ->
    super + @message().length + 1 #1 is type() length

  package: (buffer) =>
    buffer.join [@type()], 1
    buffer.join @message(), 2
