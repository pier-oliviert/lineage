chrome.app.Models.Character = class Character

  constructor: (packet) ->
    @name = packet.name()
    @pledge = packet.pledge()

  texture: ->
    PIXI.Texture.fromImage("assets/textures/bunny.png")

  sprite: ->
    new PIXI.Sprite @texture()
