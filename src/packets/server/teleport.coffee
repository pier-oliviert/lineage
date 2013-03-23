class TeleportPacket extends chrome.app.Packets.ReceivedPacket
  id: 11
  constructor: (@data) ->
    @attributes @data,
      unknown: "int16"
      characterId: "int32"

PacketId.Teleport = 11
chrome.app.Routes[11] = TeleportPacket
