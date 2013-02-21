class @Packet
  packaged: undefined

  constructor: (op) ->
    @op = op

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
  # Uint8Array that is available for work.
  # We are using Uint8Array since it's the way the server interprets packet
  # https://developer.mozilla.org/en-US/docs/JavaScript/Typed_arrays?redirectlocale=en-US&redirectslug=JavaScript_typed_arrays
  # Note:
  #   - The opcode is already filled.
  #   - The high & low byte are already filled based on length()
  #   - You have to overwrite this method
  #   - When your packaging is done. You have to call @packaged(arr) to notify the callback
  ###
  package: (buffer) =>
    buffer


  ###
  # Don't subclass this method. 
  # Subclass @package instead!
  ###
  bufferize: (callback) ->
    throw "Error: No callbacks given. This packet won't be sent" unless callback?
    @packaged = callback
    view = new Int8Array(@length())
    view[0] = @op & 0xFF

    @package view

