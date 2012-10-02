jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination a[rel="next"]').attr('href')
      if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').html('<div class="loading"></div>')
        $.getScript(url)
    $(window).scroll()
