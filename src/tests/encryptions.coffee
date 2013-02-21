class @TestEncryptions
  constructor: ->
    base = [34, 51, 0, -28, 4, 0, 0, 0, 70, 61, 32, 0]
    encrypted = new Encryptor().process(new Int8Array(base))
    decrypted = new Decryptor().process(new Int8Array(encrypted))

    console.log(base)
    console.log(encrypted)
    console.log(decrypted)

