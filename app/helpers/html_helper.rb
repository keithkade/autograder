require 'pp'


module HtmlHelper
  
# Use this function in views
# This allows very basic markup language support, including block quotes
  def markup(raw_string)
    raw_string = sanitize(raw_string)
    raw_string = raw_string.gsub(/\*\*(.+)\*\*/, '<strong>\1</strong>').gsub(/__(.+)__/, '<strong>\1</strong>')
    raw_string = raw_string.gsub(/~~(.+)~~/, '<del>\1</del>')
    raw_string = raw_string.gsub(/\*(.+)\*/, '<em>\1</em>').gsub(/_(.+)_/, '<em>\1</em>')
    raw_string = raw_string.gsub(/\[(.+)\]\((.+)\)/, '<a href="\2">\1</a>')
    raw_string = raw_string.gsub(/```[\n\r]*(.+)[\n\r]*```/m, '<pre><code>\1</code></pre>').gsub(/`(.+)`/, '<code>\1</code>')
    html_multi_line_format(raw_string)
  end
  
  def html_multi_line_format(raw_string)
    output_string = ""
    if not raw_string.nil?
      in_pre = false
      raw_string.each_line do |line|
        if /^<pre>/ =~ line
          in_pre = true
        end
        
        if not in_pre
          output_string += "<p>#{line}</p>"
        else
          output_string += line
        end
        
        if /<\/pre>$/ =~ line
          in_pre = false
        end
      end
      output_string = output_string.html_safe
    end
    return output_string
  end
  
  def sanitize(raw_string)
    raw_string.gsub(/</, "&lt").gsub(/>/, "&gt;")
  end

end
