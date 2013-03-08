chrome.app.Engine.Background = class Background
  constructor: (html) ->
    @$html = $(html)
    @loaded = true

  html: ->
    @$html

