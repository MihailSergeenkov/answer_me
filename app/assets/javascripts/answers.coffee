# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()
  $('.answers .new-comment-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('postId')
    $('#answer-' + answer_id + ' .form-comment').show()
  $('.best-answer').appendTo('#best')
  $('.answers .vote-up-on, .answers .vote-down-on, .answers .vote-reset').bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText)
    if response.voted
      $('#answer-' + response.post_id + ' .vote-reset').removeAttr('disabled')
      $('#answer-' + response.post_id + ' .vote-up-on').attr('disabled', 'disabled').removeClass('vote-up-on').addClass('vote-up-off')
      $('#answer-' + response.post_id + ' .vote-down-on').attr('disabled', 'disabled').removeClass('vote-down-on').addClass('vote-down-off')
    else
      $('#answer-' + response.post_id + ' .vote-reset').attr('disabled', 'disabled')
      $('#answer-' + response.post_id + ' .vote-up-off').removeAttr('disabled').removeClass('vote-up-off').addClass('vote-up-on')
      $('#answer-' + response.post_id + ' .vote-down-off').removeAttr('disabled').removeClass('vote-down-off').addClass('vote-down-on')
    $('#answer-' + response.post_id + ' .rating').text(response.rating)
$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
