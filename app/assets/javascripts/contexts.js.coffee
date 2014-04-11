@contexts_update = (bbs_thread_id, contexts_last_no, html_contents) ->
  $(".bbs_thread_" + bbs_thread_id + " .insert_new_contexts").before(html_contents)
  $(".bbs_thread_" + bbs_thread_id + " #context_no").val(contexts_last_no + 1)
  $(".bbs_thread_" + bbs_thread_id + " #context_description").val("")

@re_contexts_update = (bbs_thread_id, context_id, margin) ->
  context_no    = $("#context_" + context_id).data("no")

  $.ajax
    type: "POST"
    url: "/contexts/" + context_id + "/recontexts.js"
    data: "no=" + context_no + "&bbs_thread_id=" + bbs_thread_id + "&margin=" + margin

@context_abone = (context_id) ->
  $("#context_" + context_id + " .context_user_name").text("あぼーん")
  $("#context_" + context_id + " .context_created_at").text("あぼーん")
  $("#context_" + context_id + " .context_description").text("あぼーん")
  $("#context_" + context_id + " .context_destroy_button").hide()
