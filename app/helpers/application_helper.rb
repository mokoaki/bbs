module ApplicationHelper
  def youbi(wday)
    (@youbi ||= ['月','火','水','木','金','土','日'])[wday]
  end

  def wrap(description)
    max_width        = 30
    zero_width_space = '&#8203;'
    regex            = /.{1,#{max_width}}/

    description.split(/\r\n|\r|\n/).map do |description_line|
      description_line.split(' ').map do |text|
        text.scan(regex).map do |split_text|
          h split_text
        end.join(zero_width_space)
      end.join(' ')
    end.join('<br />')
  end
end
