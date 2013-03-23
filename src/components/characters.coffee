chrome.app.Components.Characters = class Characters
  constructor: (@stage, @player) ->
    @onScreen = []
    @add @player

  add: (character) ->
    @stage.addChild character.sprite
    @onScreen.push character
    character.sprite.mouseover = (data) ->
      console.log data.target.character.name

  remove: (character) ->
    @stage.removeChild character.sprite
    @onScreen.splice @onScreen.indexOf(character), 1

  isOnScreen: (character) ->
    @onScreen.indexOf(character) isnt -1

  delta: (character) ->
    x: character.x - @player.x
    y: character.y - @player.y
