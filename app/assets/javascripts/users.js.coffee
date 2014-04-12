@page = 0

@new_users_search = ->
  self.page = 1
  users_search_method()

@next_page_button = ->
  if 0 < self.page
    self.page += 1
    users_search_method()

@before_page_button = ->
  if 1 < self.page
    self.page -= 1
    users_search_method()

@users_search_method = ->
  $('#page').text(self.page)

  $.ajax
    type: "POST"
    url: "/users/search.js"
    data: "search[name]=" + $("#search_name").val() + "&search[email]=" + $("#search_email").val() + "&page=" + self.page

@plate_access_button = ->
  plate_id = $(this).data("plate_id")
  user_id  = $(this).data("user_id")

  if $(this).hasClass("plate_access_ok")
    access = "ok"

    ##この処理はjs戻り値にてやるべきかなと
    $(this).addClass("plate_access_ng")
    $(this).removeClass("plate_access_ok")
  else
    access = "ng"

    ##この処理はjs戻り値にてやるべきかなと
    $(this).addClass("plate_access_ok")
    $(this).removeClass("plate_access_ng")

  $.ajax
    type: "POST"
    url: "/users/plate_access.js"
    data: "plate_id=" + plate_id + "&user_id=" + user_id + "&access=" + access

