chrome.app.Controllers.Game = class GameController
  constructor: (@player) ->
    packet = new chrome.app.Packets.SelectCharacter(@player)
    packet.bufferize Lineage.socket.send
    @stage = new PIXI.Stage(0xFFFFFF)
    @renderer = PIXI.autoDetectRenderer(1024,768)
    @components() #initialize

    $container = $("<div id='game'>").appendTo $(document.body).empty()
    $container.append @renderer.view

    sprite = @player.sprite()
    sprite.position.x = @renderer.width / 2
    sprite.position.y = @renderer.height / 2

    sprite.anchor.x = 0.5
    sprite.anchor.y = 0.5

    @stage.addChild( sprite )

    @eventify $(document.body)

    @renderer.render(@stage)

    requestAnimationFrame( @render )

  components: ->
    if @components.value?
      return @components.value if arguments.length is 0
      return @components.value[arguments[0]]

    @components.value = {}
    @components.value.chat = new chrome.app.Components.Chat

    @components.value

  render: =>
    @renderer.render(@stage)
    requestAnimationFrame( @render )

  eventify: ($html) ->
    $html.on "submit", "form", (e) ->
      $input = $(this).children("input").first()
      message = $input.val()
      $input.val("")
      global = $("#chat ul.types li.active").hasClass("global")
      packet = new chrome.app.Packets.Chat(message, global)
      packet.bufferize Lineage.socket.send
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
        console.log packet
    console.log(packet)
