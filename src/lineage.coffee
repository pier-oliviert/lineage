# Live: 98.248.13.98
class Lineage
  constructor: ->
    @socket = new Socket("98.248.13.98", 2000)
    @controllers = []
    login = new chrome.app.Controllers.Login
    @push(login)

  push: (controller) ->
    controller.render()
    @controllers.push controller

  pop: (controller) ->
    @controllers.slice(@controllers.indexOf(controller), 0)

  current: ->
    @controllers[@controllers.length - 1]


$ ->
  window.Lineage = new Lineage()
