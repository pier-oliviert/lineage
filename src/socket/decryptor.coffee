class @Decryptor extends Encryption

  process: (data) ->
    size = data.length
    keys = @keys @seed

    third = data[3]
    data[3] ^= keys[2]

    second = data[2]
    data[2] ^= (third ^ keys[3])

    first = data[1]
    data[1] ^= (second ^ keys[4])

    key = data[0] ^ first ^ keys[5]
    data[0] = key ^ keys[0]

    `for (var i = 1; i < size; i++) {
      t = data[i]
      data[i] ^= (keys[i & 7] ^ key)
      key = t
    }`

    @update(@mask(data))

    data
