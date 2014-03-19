require 'helper'

module ParserTest
  include Fluent

  def str2time(str_time, format = nil)
    if format
      Time.strptime(str_time, format).to_i
    else
      Time.parse(str_time).to_i
    end
  end
end

class ElasticsearchParserTest < Test::Unit::TestCase
  include ParserTest
  
  def setup
    TextParser.new
    @parser = TextParser::TEMPLATE_FACTORIES['elasticsearch'].call
  end

  def test_call
    time, record = @parser.call('[2014-03-18 18:27:34,897][INFO ][http                     ] [es01] bound_address {inet[/0:0:0:0:0:0:0:0:9200]}, publish_address {inet[/10.0.0.185:9200]}')

    assert_equal(str2time('2014-03-18 18:27:34,897', '%Y-%m-%d %H:%M:%S,%L'), time)
    assert_equal({
      'log_level' => 'INFO',
      'log_type' => 'http',
      'node_name' => 'es01',
      'message' => 'bound_address {inet[/0:0:0:0:0:0:0:0:9200]}, publish_address {inet[/10.0.0.185:9200]}'
    }, record)
  end
end

class PostfixParserTest < Test::Unit::TestCase
  include ParserTest
  
  def setup
    TextParser.new
    @parser = TextParser::TEMPLATE_FACTORIES['postfix'].call
  end

  def test_call
    time, record = @parser.call('2012-03-26T19:49:56+09:00 worker001 postfix/smtp[13747]: 31C5C1C000C: to=<foo@example.com>, relay=mx.example.com[127.0.0.1]:25, delay=0.74, delays=0.06/0.01/0.25/0.42, dsn=2.0.0, status=sent (250 ok dirdel)')

    assert_equal(str2time('2012-03-26T19:49:56+09:00', '%Y-%m-%dT%H:%M:%S %z'), time)
    assert_equal({
      'host' => 'worker001',
      'process' => 'postfix/smtp[13747]',
      'message' => '31C5C1C000C: to=<foo@example.com>, relay=mx.example.com[127.0.0.1]:25, delay=0.74, delays=0.06/0.01/0.25/0.42, dsn=2.0.0, status=sent (250 ok dirdel)',
      'key' => '31C5C1C000C',
      'address' => 'foo@example.com',
    }, record)
  end
end
