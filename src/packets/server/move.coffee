class MovePacket extends chrome.app.Packets.ReceivedPacket
  id: 126
  constructor: (@data) ->
    @attributes @data,
      characterId: "int32",
      x: "int16",
      y: "int16",
      heading: "int8"

chrome.app.Routes[126] = MovePacket

PacketId.Move = 126
