# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('.edit-question').show()
  $('.question .new-comment-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('.question .form-comment').show()
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
  PrivatePub.subscribe '/questions',(data, channel) ->
    questionData = data['question']
    $('.questions').append("<div class='col-md-6'>" +
                             "<div class='panel panel-default'>" +
                               "<p class='panel-heading'>" +
                                 "<a href=/questions/" + questionData[0] + ">" + questionData[1] + "</a>" +
                               "</p>" +
                               "<p class='panel-body'>" + questionData[2] + "</p>" +
                             "</div>" +
                           "</div>")

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
