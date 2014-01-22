module ApplicationHelper
  def markdownify(text)
    Maruku.new(text).to_html.html_safe
  end
end
