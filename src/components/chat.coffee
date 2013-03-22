chrome.app.Components.Chat = class Chat
  constructor: ->
    Lineage.templates.get("templates/chat.html", this)
    @history = {
      normal: []
      whisper: []
      global: []
      clan: []
      trade: []
    }

  html: (html) ->
    return @html.value if arguments.length is 0
    @html.value = $(html)
    @html.value

  loaded: ->
    $("#game").append @html()
    @$types = @html().find("ul.types")
    @$types.children(".global").addClass("active")

    this.$active = this.$types.children(".active")

  received: (packet) ->
    @update(packet.type(), @compile(packet))

  compile: (packet) ->
    console.log packet
    if packet.type() is "whisper"
      $("<li>#{packet.character()}: #{packet.message()}</li>")
    else
      $("<li>#{packet.message()}</li>")

  update: (type, $li) ->
    $el = @html().find(".#{type}")
    @history[type].push $li

    if this.$active.hasClass(type)
      @html().find(".history").append($li)

  toggle: ($element) ->
    @html().find(".active").removeClass("active")
    $element.addClass("active")
    this.$active = $element
    @html().find(".history").html @history[$element.attr("type")]

  send: (message, type) ->
    packet = new chrome.app.Packets.Chat(message, type)
    packet.bufferize Lineage.socket.send

