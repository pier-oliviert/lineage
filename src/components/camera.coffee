chrome.app.Components.Camera = class Camera
  constructor: (@renderer) ->
    @center =
      x: @renderer.width / 2
      y: @renderer.height / 2

  move: (character, delta) ->

  position: (character, delta) ->
    character.sprite.position.x = @center.x + delta.x * 32
    character.sprite.position.y = @center.y + delta.y * 32

  update: (stage) ->
    @renderer.render(stage)
