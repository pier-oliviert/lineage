chrome.app.Engine.progress = class Progress
  constructor: (@elements) ->

  update: (el) =>
    idx = @elements.indexOf(el)
    @elements.splice(idx, 1)
    @elements.length == 0
