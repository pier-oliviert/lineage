chrome.app.Components.Tiles = class Tiles
  constructor: (stage, options = {}) ->
    offset = {x:0, y:0}
    @textures =
      normal: new PIXI.Texture.fromImage("assets/textures/tile.png")
      hover: new PIXI.Texture.fromImage("assets/textures/tile-hover.png")

    @placeTile(stage, offset, options.tileSize, {width: options.width, height: options.height})

  tiles: ->
    @tiles = ->
      @tiles.value
    @tiles.value = []
    @tiles()

  placeTile: (stage, offset, tileSize, canvasSize) ->
    tile = new PIXI.Sprite(@textures.normal)
    tile.width = tile.height = tileSize
    tile.position = new PIXI.Point(offset.x, offset.y)
    stage.addChild tile
    @tiles().push tile
    offset.x += tile.width

    if offset.x >= canvasSize.width
      offset.x = 0
      offset.y += tile.height
      return @tiles() if offset.y >= canvasSize.height

    @placeTile(stage, offset, tileSize, canvasSize)


  update: (stage) ->
    @renderer.render(stage)

  focus: (data) =>
    sprite = data.target
    sprite.setTexture(@textures.hover)


  blur: (data) =>
    sprite = data.target
    sprite.setTexture(@textures.normal)
