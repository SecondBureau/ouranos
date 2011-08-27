# script for post

goToByScroll = (id) ->
  $("html, body").delay(200).animate({
    scrollTop: $("#" + id).offset().top - 10
  }, 1500)
  
