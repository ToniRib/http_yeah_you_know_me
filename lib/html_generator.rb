class HtmlGenerator
  def wrap_response(text)
    "<pre>#{text}</pre>"
  end

  def wrap_diagnostics(text)
    "<pre>#{text}</pre>"
  end

  def generate(response, diagnostics)
    "<html><head></head><body>#{wrap_response(response)}#{wrap_diagnostics(diagnostics)}</body></html>"
  end
end
