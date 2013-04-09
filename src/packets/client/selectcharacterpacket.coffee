chrome.app.Packets.SelectCharacter = class SelectCharacterPacket extends Packet
  constructor: (@character) ->
    super(89, ["name"])
    @name @character.name

  name: ->
    return if arguments.length is 0
    @process arguments[0], "name"

  length: ->
    super + @name().length

  package: (buffer) ->
    buffer.join @name(), 1
