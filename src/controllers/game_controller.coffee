chrome.app.Controllers.Game = class GameController
  constructor: (@player) ->
    packet = new chrome.app.Packets.SelectCharacter(@player)
    packet.bufferize Lineage.socket.send
    @stage = new PIXI.Stage(0xFFFFFF, true)
    renderer = PIXI.autoDetectRenderer(1024,768)
    @components
      chat: new chrome.app.Components.Chat
      tiles: new chrome.app.Components.Tiles(@stage, width: renderer.width, height: renderer.height, tileSize:32)
      characters: new chrome.app.Components.Characters(@stage, @player)
      camera: new chrome.app.Components.Camera(renderer)

    $container = $("<div id='game'>").appendTo $(document.body).empty()
    $container.append renderer.view

    @eventify $(document.body)

    renderer.render(@stage)

    requestAnimationFrame( @render )


  character: (packet, initializeIfNotCached) ->
    @character = (packet, initializeIfNotCached = false) ->
      character = @character.cache[packet.characterId()]
      if character?
        character.update(packet)
      else if initializeIfNotCached
        character = new chrome.app.Models.Character(packet)
        @character.cache[character.id] = character
      character

    @character.cache = {}

    # Assumption that the first character to be fetched is ourself. Since the player doesn't have its ID yet,
    # it's manually pushed on the stack
    @player.update(packet)
    @character.cache[@player.id] = @player
    @player

  components: ->
    if @components.value?
      return @components.value if arguments.length is 0
      return @components.value[arguments[0]]

    @components.value = {}
    for name, component of arguments[0]
      @components.value[name] = component

    @components.value

  render: =>
    @components("camera").update(@stage)
    requestAnimationFrame( @render )

  eventify: ($html) ->
    $html.on "submit", "form", (e) =>
      $input = $(e.target).children("input").first()
      message = $input.val()
      $input.val("")
      type = $("#chat ul.types li.active").attr("type")
      @components("chat").send message, type
      false

    $html.on "click", "#chat ul.types li", (e) =>
      @components("chat").toggle($(e.target))

  received: (packet) ->
    switch packet.id
      when PacketId.Chat, PacketId.GlobalChat, PacketId.WhisperChat
        @components("chat").received(packet)
      when PacketId.CharInfo
        @update(@player.find(packet))
      when PacketId.Player
        characters = @components("characters")
        if packet.name()[0] isnt "$"
          character = @character(packet, true)
          characters.add(character) unless characters.isOnScreen(character)
          @components("camera").position character, characters.delta(character)

      when PacketId.Move
        character = @character(packet)
        if character?
          characters = @components("characters")
          @components("camera").position(character, characters.delta(character))
      when PacketId.Remove
        character = @character(packet)
        if character?
          characters = @components("characters")
          characters.remove(character) if characters.isOnScreen(character)
