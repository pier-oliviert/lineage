class PlayerPacket extends chrome.app.Packets.ReceivedPacket
  id: 1
  constructor: (@data) ->
    @attributes @data,
      x: "int16",
      y: "int16",
      characterId: "int32",
      spriteId: "int16",
      status: "int8",
      heading: "int8",
      light: "int8",
      speed: "int8",
      experience: "int32",
      lawful: "int16",
      name: "string",
      title: "string",
      state: "int8"

      

chrome.app.Routes[1] = PlayerPacket
PacketId.Player = 1
