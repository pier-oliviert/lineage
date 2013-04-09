chrome.app.Packets.Chat = (type) ->
  klass = chrome.app.Packets.Chat[type]
  throw "Error: Couldn't find a chat packet of type #{type}" unless klass?
  new klass

