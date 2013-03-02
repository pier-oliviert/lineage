chrome.app.Models.Character = class Character

  constructor: (packet) ->
    @name = packet.name()
    @pledge = packet.pledge()

