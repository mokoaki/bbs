@contexts_update = (bbs_thread_id, contexts_last_no, html_contents) ->
  $(".bbs_thread_" + bbs_thread_id + " .insert_new_contexts").before(html_contents)
  $(".bbs_thread_" + bbs_thread_id + " #context_no").val(contexts_last_no + 1)
  $(".bbs_thread_" + bbs_thread_id + " #context_description").val("")
