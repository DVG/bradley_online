module ApplicationHelper
  class HTMLWithPrettyPrint < Redcarpet::Render::HTML
    def block_code(code, language)
      "<pre class=\"prettyprint linenums\">#{code}</pre>"
    end
  end
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(HTMLWithPrettyPrint, :fenced_code_blocks => true)
    markdown.render(text).html_safe
  end
end
