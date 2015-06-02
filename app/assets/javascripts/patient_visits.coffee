# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.number_to_euro = (x) ->
  x = String(x)
  console.log(x)
  x = x.replace('.', '#')
  x = x.replace(',', '.')
  x = x.replace('#', ',')
  x = x + '&nbsp;&euro;'
  x
