chrome.app.Packets.Chat.Whisper = class ChatPacket extends Packet

  constructor: ->
    super 92, ["message", "target"]

  message: ->
    return if arguments.length is 0
    @process arguments[0], "message"

  target: ->
    return if arguments.length is 0
    @process arguments[0], "target"

  length: ->
    super + @message().length + @target().length

  package: (buffer) =>
    buffer.join @target(), 1
    buffer.join @message(), @target().length + 1

