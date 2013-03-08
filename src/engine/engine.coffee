chrome.app.Engine = class Engine
  ###
  # Elements are all the elements to load asynchronously
  ###
  constructor: (elements) ->
    @components = {}
    @progress = new chrome.app.Engine.progress(elements)
    @load(element) for element in elements

  load: (element) =>
    $.get element.url, (data) =>
      @components[element.name] = new element.logic(data)
      finished = @progress.update element
      @render() if finished

  render: =>
    $background = @components.background.html()
    $(document.body).html($background)
    $background.append @components.chat.html()
