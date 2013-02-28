chrome.app.Controllers.Characters = class CharactersController
  constructor: ->
    packet = new chrome.app.Packets.Click()
    packet.bufferize Lineage.socket.send

  render: ->
    unless @$template?
      $.get @templateURL(), (text) =>
        @$template = $(text)
        @render()

      return this

    $(document.body).html(@$template)
    @eventify(@$template)

  templateURL: ->
    "/templates/characters.html"


  eventify: ($html) ->
    $html.on "click", ".select", ->
      character = $(this).parent().data("character")
      Lineage.push( new chrome.app.Controllers.Game(character) )

  received: (packet) ->
    switch packet.id
      when PacketId.CharAmount
        @characters = new Array()
        @characters.amount = packet.amount()
      when PacketId.CharInfo
        @characters.push(new chrome.app.Models.Character(packet))

        if @characters.amount is @characters.length
          @update()

    console.log packet

  update: ->
    $list = $("#charactersList")
    $list.empty()

    $ul = $("<ul>")

    for character in @characters
      $li = $("<li>")
      $li.append("<h3>#{character.name}</h3>")
      $li.append("<a href='#' class='select'>#{character.name}</a>")
      $li.data("character", character)
      $ul.append($li)

    $list.html($ul)
