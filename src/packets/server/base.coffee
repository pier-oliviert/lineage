class chrome.app.Packets.ReceivedPacket
  attributes: (data, map) ->
    for fn, type of map
      @[fn] = (value) ->
        return @[fn].value if arguments.length is 0
        @[fn].value = value
        @[fn].value

    @data.parse this, map
