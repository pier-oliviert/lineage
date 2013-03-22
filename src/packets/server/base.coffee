class chrome.app.Packets.ReceivedPacket
  attributes: (data, map) ->
    @setAttribute(fn) for fn of map
      @setAttribute(fn)
    @data.parse this, map

  setAttribute: (fn) ->
    @[fn] = (value) ->
      return @[fn].value if arguments.length is 0
      @[fn].value = value
      @[fn].value

