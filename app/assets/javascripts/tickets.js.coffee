# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# 
$(document).on 'ajax:success', '#createTicket', (xhr, data, status) ->
  location.reload()

$(document).on 'ajax:error', '#createTicket', (xhr, data, status) ->
  form = $('#new_ticket .modal-body')
  div = $('<div></div>').attr(id: 'createTicketErrors').addClass('alert alert-danger')
  ul = $('<ul></ul>')
  data.responseJSON.messages.forEach (message, i) -> 
    li = $('<li></li>').text(message)
    ul.append(li)

  if $('#createTicketErrors')[0]
    $('#createTicketErrors').html(ul)    
  else
    div.append(ul)
    form.prepend(div)