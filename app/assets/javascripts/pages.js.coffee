
show_side_content = (element_id) ->
  $(element_id).find(".home_side_block_content").show()
    
hide_side_content = (element_id) ->
  $(element_id).find(".home_side_block_content").hide()
    
init_show_default_blocks = (element_ids) ->
  for element_id in element_ids
    do (element_id) ->
      if $.cookie(element_id) == "true"
        show_side_content("#" + element_id)
      else if $.cookie(element_id) == "false"
        hide_side_content("#" + element_id)
      else
        show_side_content("#" + element_id)

init_hide_default_blocks = (element_ids) ->
  for element_id in element_ids
    do (element_id) ->
      if($.cookie(element_id) != "true" && $.cookie(element_id) != "false")
        hide_side_content("#" + element_id)
          
$ ->
  init_show_default_blocks(["calendar", "categories", "contact", "most_read_posts", "recent_comments"])
  init_hide_default_blocks(["most_read_posts", "recent_comments"])
  
  $(".home_side_block_title").click ->
    el = $(this).parent().find(".home_side_block_content")
    el.slideToggle ->
      if el.css("display") == "block"
        $.cookie(el.parent().attr("id"), "true", { path: "/" })
      else
        $.cookie(el.parent().attr("id"), "false", { path: "/" })
    
