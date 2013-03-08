chrome.app.Engine.Chat = class Chat
  constructor: (html) ->
    @$html = $(html)
    @$types = @$html.find("ul.types")
    @$types.children(".global").addClass("active")
    @$types.children("li").each ->
      $(this).data "history", []

    this.$active = this.$types.children(".active")
    @loaded = true

  html: ->
    @$html

  received: (packet) ->
    @update(packet.type, @compile(packet))

  compile: (packet) ->
    $("<li>#{packet.message()}</li>")

  update: (type, $li) ->
    $el = @$types.find(".#{type}")
    $el.data("history").push $li

    if this.$active.hasClass(type)
      this.$html.find(".history").append($li)

  toggle: ($element) ->
    this.$html.find(".active").removeClass("active")
    $element.addClass("active")
    this.$active = $element
    this.$html.find(".history").html $element.data("history")
