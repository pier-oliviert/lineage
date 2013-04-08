chrome.app.Packets.Chat = class ChatPacket extends Packet
  types:
    normal: 0
    whisper: 1
    shouting: 2
    global: 3
    clan: 4

  constructor: (message, type) ->
    super @opcode(type), ["message", "type"]
    @type @types[type]
    @message message

  opcode: (type) ->
    switch @types[type]
      when 3
        return 115
      when 0, 2, 4
        return 18
      when 1
        return 92

  message: ->
    return if arguments.length is 0
    @process arguments[0], "message"

  type: ->
    return if arguments.length is 0
    @packed "type", arguments[0] & 0xFF

  length: ->
    super + @message().length + 1

  packaged: (buffer) =>
    buffer.join [@type() & 0xFF], 1
    buffer.join @message(), 2
