chrome.app.Packets.SelectCharacter = class SelectCharacterPacket extends Packet
  constructor: (character) ->
    @character = character
    super(89)

  length: ->
    super + @character.name.length + 1

  package: (view) =>
    @character.name.bufferize (name) =>
      view.join name, 1
      @packaged(view)
