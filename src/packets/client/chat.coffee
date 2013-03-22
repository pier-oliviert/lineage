chrome.app.Packets.Chat = class ChatPacket extends Packet
  types:
    normal: 0
    shouting: 2
    global: 3
    clan: 4
  constructor: (@message, type) ->
    @type = @types[type]
    super if @type is 3 then 115 else 18

  length: ->
    super + @message.length + 2

  package: (view) =>
    view.join [@type & 0xFF], 1
    @message.bufferize (msg) =>
      view.join msg, 2
      @packaged view
