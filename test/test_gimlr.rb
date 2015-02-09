require 'minitest/autorun'
require 'gimlr'

class TestGimlr < Minitest::Unit::TestCase
  def test_gimlr_parse_integer
    expected = { 'num_var' => 12 }
    assert_equal expected, Gimlr.parse_string(":num: num_var\n12")
  end

  def test_gimlr_parse_float
    expected = { 'num_var' => 1.2 }
    assert_equal expected, Gimlr.parse_string(":num: num_var\n1.2")
  end

  def test_gimlr_parse_oneline_string
    expected = { 'str' => 'Lorem' }
    assert_equal expected, Gimlr.parse_string(":text: str\nLorem")
  end

  def test_gimlr_parse_multiline_string
    expected = { 'str' => "Lorem\nipsum" }
    assert_equal expected, Gimlr.parse_string(":text: str\nLorem\nipsum")
  end

  def test_gimlr_parse_list
    expected = { 'list' => %w[a b c] }
    assert_equal expected, Gimlr.parse_string(":list: list\na, b, c")
  end

  def test_gimlr_parse_vlist
    expected = { 'list' => %w[a b c] }
    assert_equal expected, Gimlr.parse_string(":vlist: list\n- a\n- b\n- c")
  end

  def test_gimlr_parse_multiple_values
    expected = { 'list' => %w[a b c], 'num_var' => 1, 'str' => 'abc' }
    data = ":list: list\na, b, c\n:num: num_var\n1\n:text: str\nabc"
    assert_equal expected, Gimlr.parse_string(data)
  end

  def test_gimlr_parse_properly_handle_ending_line
    expected = { 'list' => %w[a b c] }
    data = ":list: list\na, b, c\n"
    assert_equal expected, Gimlr.parse_string(data)
  end

  def test_gimlr_parse_list_properly_handle_beginning_and_ending_line
    expected = { 'list' => %w[a b c] }
    data = ":list: list\n\na, b, c\n\n"
    assert_equal expected, Gimlr.parse_string(data)
  end

  def test_gimlr_parse_list_properly_handle_ending_line_comma
    expected = { 'list' => %w[a b c d e f] }
    data = ":list: list\na, b, c,\nd, e, f,\n"
    assert_equal expected, Gimlr.parse_string(data)
  end

  def test_gimlr_parse_text_properly_handle_beginning_and_ending_line
    expected = { 'text' => "this is\ntext" }
    data = ":text: text\n\nthis is\ntext\n\n"
    assert_equal expected, Gimlr.parse_string(data)
  end

  def test_gimlr_parse_properly_handle_comments
    expected = { 'list' => %w[a b c] }
    data = "#comment\n:list: list\na, b, c\n"
    assert_equal expected, Gimlr.parse_string(data)
  end

  def test_gimlr_parse_file
    expected = {
      'this_is_text' => "Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text\nSome text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text",
      'this_is_num' => 12345,
      'this_another_num' => 123.234,
      'this_is_array' => %w[1 2 3 4 5 1 2 3 4 5],
      'this_is_another_array' => %w[1 2 3 4 5 6]
    }
    file = File.expand_path('test_file.giml', File.dirname(__FILE__))
    assert_equal expected, Gimlr.parse_file(file)
  end
end
