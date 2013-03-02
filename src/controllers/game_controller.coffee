chrome.app.Controllers.Game = class GameController
  constructor: (character) ->
    @character = character
    packet = new chrome.app.Packets.SelectCharacter(@character)
    packet.bufferize Lineage.socket.send

    
  render: ->
    $(document.body).empty()
    #Crafty.init(document.width, document.height)
    $(document.body).append("
      <div id='chatBox'>
        <ul class='history'>
        </ul>
        <form>
          <input type='text' placeholder='Send a message' />
          <input type='submit'>
        </form>
        </div>")

    @eventify $(document.body)


  eventify: ($html) ->
    $html.on "submit", "form", (e) ->
      $input = $(this).children("input").first()
      message = $input.val()
      $input.val("")
      packet = new chrome.app.Packets.Chat(message, true)
      packet.bufferize Lineage.socket.send
      false

  received: (packet) ->
    switch packet.id
      when PacketId.Chat, PacketId.GlobalChat, PacketId.WhisperChat
        $li =$("<li>#{packet.message()}</li>")
        $li.addClass packet.type
        $(document.body).find("ul.history").append($li)
    console.log(packet)
