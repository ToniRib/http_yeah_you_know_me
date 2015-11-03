require 'minitest/autorun'
require 'minitest/pride'
require './lib/html_generator'

class HtmlGeneratorTest < Minitest::Test
  def test_it_wraps_response_in_a_paragraph
    generator = HtmlGenerator.new
    response = 'Peter'
    expected = "<p>Peter</p>"

    assert_equal expected, generator.wrap_response(response)
  end

  def test_it_wraps_diagnostics_in_a_pre_tag
    generator = HtmlGenerator.new
    diagnostics = 'Peter'
    expected = "<pre>Peter</pre>"

    assert_equal expected, generator.wrap_diagnostics(diagnostics)
  end

  def test_it_wraps_response_and_diagnostics_in_a_html_skeleton
    generator = HtmlGenerator.new
    response = 'Banana'
    diagnostics = 'Peter'
    expected = "<html><head></head><body><p>Banana</p><pre>Peter</pre></body></html>"

    assert_equal expected, generator.generate(response, diagnostics)
  end
end
