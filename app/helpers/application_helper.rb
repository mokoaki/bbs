module ApplicationHelper
  def youbi(wday)
    (@youbi ||= ['月','火','水','木','金','土','日'])[wday]
  end

  def wrap(content)
    sanitize(raw(wrap_long_string_and_gsub_newline_to_br_tag(content)), :tags => %w(br))
  end

  private

  def wrap_long_string_and_gsub_newline_to_br_tag(content)
    max_width        = 30
    zero_width_space = '&#8203;'
    regex            = /.{1,#{max_width}}/

    content.split(/\r\n|\r|\n/).map do |content_line|
      content_line.split(' ').map do |text|
        (text.length < max_width) ? text : text.scan(regex).join(zero_width_space)
      end.join(' ')
    end.join('<br />')
  end
end
