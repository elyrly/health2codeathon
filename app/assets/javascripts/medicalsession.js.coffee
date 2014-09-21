# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('[data-toggle]').on('click', ->
    toggle = $(this).addClass('active').attr('data-toggle')
    $(this).siblings('[data-toggle]').removeClass('active')
    $('.surveys').removeClass('grid list').addClass(toggle)
  )