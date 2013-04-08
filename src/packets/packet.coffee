class @Packet
  packaged: undefined

  constructor: (op, types = []) ->
    @op = op
    @states(types)
    @ready() if @states().length is 0

  ready: ->
    @packaged( @buffer() )
    for callback in @onReady()
      callback @buffer()

  onReady: ->
    @onReady = ->
      return @onReady.value if arguments.length is 0
      if @states().length is 0
        arguments[0](@buffer())
      else
        @onReady.value.push arguments[0]

    @onReady.value = []
    @onReady.value.push arguments[0] unless arguments.length is 0
    @onReady()


  ###
  # return unprocessed states.
  # The types given in the constructor is passed
  # to this function will save the states.
  # when packed() is called, it will removed the state
  # associated with the packed data.
  ###
  states: ->
    @states = ->
      return @states.value if arguments.length is 0
      @states.value = arguments[0]

    @states.value = arguments[0]
    @states()

  ###
  # Callback triggered when a data that needed processing is done
  # This can be called by a packet directly if no processing needs to 
  # be done. An example would be to set an integer.
  # This will replace the initial function with a 
  # getter that can be used by the packet to assemble
  # the buffer before sending it down the pipes.
  #
  # Updates @states(), if no state need to be processed. Calls @ready()
  ###
  packed: (type, data) ->
    @[type] = ->
      data
    @states().splice @states().indexOf(type), 1

    @ready() if @states().length is 0


  ###
  # Int8Array that is available for work.
  # We are using Int8Array since it's the way the server interprets packet
  # https://developer.mozilla.org/en-US/docs/JavaScript/Typed_arrays?redirectlocale=en-US&redirectslug=JavaScript_typed_arrays
  # Note:
  #   - The opcode is already filled.
  #   - The high & low byte are already filled based on length()
  #   - You should overwrite this method, unless you don't need to add anything
  ###
  packaged: (buffer) ->

  ### You should use this method when you want to 
  # send a string in the packet. This will call @packed()
  # when done.
  ###
  process: (string, type) ->
    b = new Blob([string])
    f = new FileReader()
    f.onload = (e) =>
      buffer = new Uint8Array e.target.result
      data = new Uint8Array(buffer.length + 1)
      data.set(buffer)
      @packed(type, data)
    f.readAsArrayBuffer(b)
    this

  ###
  # returns the expected length of the buffer.
  # The length is a multiple of 8 since we are
  # using 8 bytes encodings
  # Note:
  #   - You have to overwrite this method
  #   - By default you want to send the opcode(1)
  #
  ###
  length: ->
    1

  ###
  # Don't subclass this method. 
  # Subclass @package instead!
  #
  #   Discussion: Since the encryption is being done using the 4 first byte, a packet has to be
  #   at least 4 bytes wide.
  ###
  buffer: ->
    @buffer = ->
      @buffer.value

    buffer = new Int8Array(Math.max(@length(), 4))
    buffer[0] = @op & 0xFF
    @buffer.value = buffer
    @buffer()

