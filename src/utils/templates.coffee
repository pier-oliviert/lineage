class @Templates

  get: (file, obj) ->
    request = new XMLHttpRequest()
    request.callbackObject = obj
    request.file = file
    request.addEventListener "load", @requestLoaded
    request.addEventListener "error", @requestFailed
    request.open "get", file
    request.send()

  requestLoaded: ->
    this.callbackObject["html"].call this.callbackObject, this.responseText
    this.callbackObject["loaded"].call this.callbackObject

  requestFailed: ->
    throw "Template Error: #{this}"
