require 'pp'


module HtmlHelper
  
  def html_multi_line_format(raw_string)
    output_string = ""
    if raw_string != nil
      raw_string.each_line do |line|
        output_string += "<p>#{line}</p>"
      end
      output_string = output_string.html_safe
    end
    return output_string
  end

end
