class RemovePacket extends chrome.app.Packets.ReceivedPacket
  id: 0
  constructor: (@data) ->
    @attributes @data,
      characterId: "int32"

PacketId.Remove = 0
chrome.app.Routes[0] = RemovePacket
