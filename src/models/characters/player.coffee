chrome.app.Models.Player = class Player extends chrome.app.Models.Character
  constructor: (packet) ->
    @pledge = packet.pledge()
    super

  update: (packet) ->
    @x = packet.x()
    @y = packet.y()

