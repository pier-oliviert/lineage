chrome.app.Controllers.Game = class GameController
  constructor: (@player) ->
    packet = new chrome.app.Packets.SelectCharacter(@player)
    packet.bufferize Lineage.socket.send
    @stage = new PIXI.Stage(0xFFFFFF, true)
    @renderer = PIXI.autoDetectRenderer(1024,768)
    @components
      chat: new chrome.app.Components.Chat

    @characters = {}

    $container = $("<div id='game'>").appendTo $(document.body).empty()
    $container.append @renderer.view

    sprite = @player.sprite
    sprite.position.x = @renderer.width / 2
    sprite.position.y = @renderer.height / 2

    @stage.addChild( sprite )

    @eventify $(document.body)

    @renderer.render(@stage)

    requestAnimationFrame( @render )

  components: ->
    if @components.value?
      return @components.value if arguments.length is 0
      return @components.value[arguments[0]]

    @components.value = {}
    for name, component of arguments[0]
      @components.value[name] = component

    @components.value

  render: =>
    @renderer.render(@stage)
    requestAnimationFrame( @render )

  move: (packet) ->
    character = @characters[packet.characterId()]
    sprite = character.sprite
    delta = {}
    delta.x = packet.x() - @player.x
    delta.y = packet.y() - @player.y
    sprite.position.x = @renderer.width / 2 + delta.x * 32
    sprite.position.y = @renderer.height / 2 + delta.y * 32 * -1

  position: (packet) ->
    unless @characters[packet.characterId()]?
      character = new chrome.app.Models.Character(packet)
      delta = {}
      delta.x = character.x - @player.x
      delta.y = character.y - @player.y

      sprite = character.sprite
      sprite.position.x = @renderer.width / 2 + delta.x * 32
      sprite.position.y = @renderer.height / 2 + delta.y * 32 * -1

      @stage.addChild sprite
    
      @characters[packet.characterId()] = character

  remove: (packet) ->
    character = @characters[packet.characterId()]
    @stage.removeChild character.sprite
    delete @characters[packet.characterId()]


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
        if @player.name == packet.name()
          @player.update( packet )
        else
          @position(packet)
      when PacketId.Move
        @move(packet)
      when PacketId.Remove
        @remove(packet)
