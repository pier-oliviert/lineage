chrome.app.Components.Chat = class Chat
  whisperRegex: /^"{1}(\w+)\s(.*)$/

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
    if packet.type() is "whisper"
      if packet.tid? && packet.tid() is 9
        $("<li>#{packet.message()}</li>")
      else
        $("<li>#{packet.character()}: #{packet.message()}</li>")
    else
      $("<li>#{packet.message()}</li>")

  update: (type, $li) ->
    $el = @html().find(".#{type}")
    @history[type].splice 0, 0, $li

    if this.$active.hasClass(type)
      @html().find(".history").prepend($li)
    else if !$el.hasClass("unseen")
      $el.addClass("unseen")

  toggle: ($element) ->
    @html().find(".active").removeClass("active")
    $element.addClass("active").removeClass("unseen")
    this.$active = $element
    @html().find(".history").html @history[$element.attr("type")]

  send: (type, message) ->
    packet = chrome.app.Packets.Chat(type.capitalize())
    if type isnt "whisper"
      packet.type(type)
      packet.message(message)
    else
      content = @whisperRegex.exec(message)
      packet.message content.pop()
      packet.target content.pop()
    packet.onReady Lineage.socket.send

