require 'pp'


module HtmlHelper
  
  def html_multi_line_format(raw_string)
    output_string = ""
    raw_string.each_line do |line|
      output_string += "<p>#{line}</p>"
    end
    output_string = output_string.html_safe
    pp output_string
    return output_string
  end

end
