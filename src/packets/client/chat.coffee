chrome.app.Packets.Chat = class ChatPacket extends Packet
  constructor: (@message) ->
    super (18)

  length: ->
    super + @message.length + 2

  package: (view) =>
    view.join [0x00], 1
    @message.bufferize (msg) =>
      view.join msg, 2
      @packaged view
