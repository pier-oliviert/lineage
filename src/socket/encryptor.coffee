class @Encryptor extends Encryption

  process: (data) ->
    keys = @keys @seed
    mask = @mask data

    data[0] ^= keys[0]

    `for (var i = 1; i < data.length; i++) {
        data[i] ^= (data[i - 1] ^ keys[i & 7])
    }`

    data[3] = (data[3] ^ keys[2])
    data[2] = (data[2] ^ data[3] ^ keys[3])
    data[1] = (data[1] ^ data[2] ^ keys[4])
    data[0] = (data[0] ^ data[1] ^ keys[5])

    @update(mask)

    data
