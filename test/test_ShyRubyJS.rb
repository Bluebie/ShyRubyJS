#require 'helper'
require 'test/unit'
require_relative '../lib/ShyRubyJS.rb'

class TestShyRubyJS < Test::Unit::TestCase
  def setup
    @parser = ShyRubyJS::ShySexpParser.new
  end
  def teardown
    @parser = nil
  end
  
  def parse(&block)
    @parser.parse_block(&block)
  end
  
  def test_simple_expressions
    expressions = []
    expressions << [%{5 * 1}, parse { 5 * 1 }]
    expressions << [%{7 + 11}, parse { 7 + 11 }]
    expressions << [%{9 + 2 + 1}, parse { 9 + 2 + 1 }]
    expressions << [%{9 <= 2}, parse { 9 <= 2}]
    expressions << [%{a = 2 + 1}, parse { a = 2 + 1}]
    expressions.each { |pair|
      assert_equal(pair[0], pair[1])
    }
    # assert_equal(expected, result)
    
  end
  
  def test_function_call
    expected = %{eggs}
    result = parse { eggs } 
    assert_equal(expected, result)
  end
  
  def test_function_call_with_arg
    expected = %{eggs(5)}
    result = parse { eggs(5) }
    assert_equal(expected, result)
  end
  
  def test_function_call_with_expression_arg
    expected = %{eggs(5 + 1)}
    result = parse { eggs(5+1) }
    assert_equal(expected, result)
  end
end