chrome.app.Routes[80] = class CharAmountPacket
  id: 80
  constructor: (data) ->
    @amount = ->
      data[0]
    @maximum = ->
      data[1]


PacketId.CharAmount = 80
