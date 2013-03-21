chrome.app.Components.Chat = class Chat
  constructor: ->
    Lineage.templates.get("templates/chat.html", this)

  html: (html) ->
    return @html.value if arguments.length is 0
    @html.value = $(html)
    @html.value

  loaded: ->
    $("#game").append @html()
    @$types = @html().find("ul.types")
    @$types.children(".global").addClass("active")
    @$types.children("li").each ->
      $(this).data "history", []

    this.$active = this.$types.children(".active")


  received: (packet) ->
    @update(packet.type, @compile(packet))

  compile: (packet) ->
    if packet.type is "whisper"
      $("<li>#{packet.character()}: #{packet.message()}</li>")
    else
      $("<li>#{packet.message()}</li>")

  update: (type, $li) ->
    $el = @$types.find(".#{type}")
    $el.data("history").push $li

    if this.$active.hasClass(type)
      @html().find(".history").append($li)

  toggle: ($element) ->
    @html().find(".active").removeClass("active")
    $element.addClass("active")
    this.$active = $element
    @html().find(".history").html $element.data("history")

