# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('.edit-question').show()
  $('.question .vote-up-on, .question .vote-down-on, .question .vote-reset').bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText)
    if response.voted
      $('.question .vote-reset').removeAttr('disabled')
      $('.question .vote-up-on').attr('disabled', 'disabled').removeClass('vote-up-on').addClass('vote-up-off')
      $('.question .vote-down-on').attr('disabled', 'disabled').removeClass('vote-down-on').addClass('vote-down-off')
    else
      $('.question .vote-reset').attr('disabled', 'disabled')
      $('.question .vote-up-off').removeAttr('disabled').removeClass('vote-up-off').addClass('vote-up-on')
      $('.question .vote-down-off').removeAttr('disabled').removeClass('vote-down-off').addClass('vote-down-on')
    $('.question .rating').text(response.rating)

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
