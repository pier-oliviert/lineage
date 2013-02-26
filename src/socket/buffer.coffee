class @Buffer
  constructor: ->
    @clear()

  ###
  # Assume that data is an instance of Uint8Array.
  # Undefined behavior otherwise!
  ###
  append: (data) ->
    for byte in data
      @bytes.push byte

  full: =>
    !@empty() && @bytes.length >= @size

  data: (reinitialize = true) =>
    data = @bytes.slice(0, @size)
    @initialize( new Uint8Array(@bytes.slice(@size)) ) if reinitialize
    data

  clear: ->
    @size = -1
    @bytes = []

  empty: ->
    @size < 0


  ###
  # Assume that data is an instance of Uint8Array.
  # Undefined behavior otherwise!
  ###
  initialize: (data) ->
    @clear()

    if data.length > 0
      flags = data.subarray(0,2)
      @size = flags[0] + flags[1] * 256 - 2

      @append( data.subarray(2) )

