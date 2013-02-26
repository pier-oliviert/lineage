chrome.app.Routes[63] = class AuthResultPacket
  id: 63
  constructor: (data) ->
    @success = ->
      data[0] == 0

    @reason = ->
      data[0]

PacketId.AuthResult = 63
