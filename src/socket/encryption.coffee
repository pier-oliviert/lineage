class @Encryption
  constructor: ->
    @seed = [1176438083, 2841787186]

  update: (mask) ->
    @seed[0] ^= mask
    @seed[1] += 0x287EFFC3

  mask: (data) ->
    ((data[3] & 0xFF) << 24) | ((data[2] & 0xFF) << 16) | ((data[1] & 0xFF) << 8) | (data[0] & 0xFF)


  keys: (seed) ->
    keys = []

    `for (var i = 0; i < seed.length; i++) {
      keys[(i * 4) + 0] = (seed[i] & 0xFF)
      keys[(i * 4) + 1] = ((seed[i] >> 8) & 0xFF)
      keys[(i * 4) + 2] = ((seed[i] >> 16) & 0xFF)
      keys[(i * 4) + 3] = ((seed[i] >> 24) & 0xFF)
    }`

    keys

  process: (data) ->
    # Process the data (encrypt/decrypt/whatever). Make sure you don't
    # call super unless you know what you are doing
    data
