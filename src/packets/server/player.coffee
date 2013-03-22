class PlayerPacket extends chrome.app.Packets.ReceivedPacket
  id: 1
  constructor: (@data) ->
    @attributes @data,
      x: "int8",
      y: "int8",
      id: "int32",
      spriteId: "int16",
      status: "int8",
      heading: "int8",
      light: "int8",
      experience: "int32",
      lawful: "int16",
      name: "string",
      title: "string"


chrome.app.Routes[1] = PlayerPacket
PacketId.Player = 1
