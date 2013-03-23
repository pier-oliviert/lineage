class TimePacket extends chrome.app.Packets.ReceivedPacket
  id: 58
  constructor: (@data) ->

PacketId.Time = 58
chrome.app.Routes[58] = TimePacket

