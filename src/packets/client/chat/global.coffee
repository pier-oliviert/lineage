chrome.app.Packets.Chat.Global = class ChatPacket extends Packet
  constructor: ->
    super 115, ["message", "type"]
    @type()

  message: ->
    return if arguments.length is 0
    @process arguments[0], "message"

  type: ->
    @packed "type", 3 && 0xFF

  length: ->
    super + @message().length + 1 #1 is type() length

  package: (buffer) =>
    buffer.join [@type()], 1
    buffer.join @message(), 2

