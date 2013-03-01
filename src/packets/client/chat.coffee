chrome.app.Packets.Chat = class ChatPacket extends Packet
  constructor: (@message, global = false) ->
    @type = if global then 3 else 0
    super if global then 115 else 18

  length: ->
    super + @message.length + 2

  package: (view) =>
    view.join [@type & 0xFF], 1
    @message.bufferize (msg) =>
      view.join msg, 2
      @packaged view
