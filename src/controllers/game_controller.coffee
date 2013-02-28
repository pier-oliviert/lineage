chrome.app.Controllers.Game = class GameController
  constructor: (character) ->
    @character = character
    packet = new chrome.app.Packets.SelectCharacter(@character)
    packet.bufferize Lineage.socket.send

    
  render: ->
    $(document.body).empty()
    Crafty.init(document.width, document.height)
