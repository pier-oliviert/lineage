chrome.app.Models.Character = class Character

  constructor: (packet) ->
    @name = packet.name()
    @x = packet.x() if packet.x?
    @y = packet.y() if packet.y?
    @sprite = new PIXI.Sprite @texture()
    @sprite.anchor.x = @sprite.anchor.y = 0.5
    @sprite.speedX = @sprite.speedY = 2
    

  texture: ->
    PIXI.Texture.fromImage("assets/textures/bunny.png")

