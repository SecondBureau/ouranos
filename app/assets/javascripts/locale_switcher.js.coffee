items = [{key:".locale", value:".locales"}, {key:".user", value:".user_links"}]

item_hover = (item) ->
  $(item.key).hover(
    -> $(item.value).slideDown("fast")
    ,
    -> $(item.value).slideUp("fast")
  )

item_hover(item) for item in items