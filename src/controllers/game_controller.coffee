chrome.app.Controllers.Game = class GameController
  constructor: (character) ->
    packet = new chrome.app.Packets.SelectCharacter(character)
    packet.bufferize Lineage.socket.send

    
  load: ->
    @engine = new chrome.app.Engine([{
      name: "background"
      url: "/templates/game.html"
      logic: chrome.app.Engine.Background
    },{
      name: "chat"
      url: "/templates/chat.html"
      logic: chrome.app.Engine.Chat
    }])

  render: ->
    $(document.body).empty()
    @load()

    @eventify $(document.body)


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
      @engine.components.chat.toggle($(e.target))

  received: (packet) ->
    switch packet.id
      when PacketId.Chat, PacketId.GlobalChat, PacketId.WhisperChat
        @engine.components.chat.received(packet)
      when PacketId.CharInfo
        @update(@character.find(packet))
    console.log(packet)
