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


  received: (packet) ->
    console.log packet

