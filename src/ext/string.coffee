String::bufferize = (callback) ->
  b = new Blob([this])
  f = new FileReader()
  f.onload = (e) ->
    callback(new Uint8Array(e.target.result))
  f.readAsArrayBuffer(b)
  this
