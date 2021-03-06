require 'test_helper'

class SysvAdapterTest < LocaljobTestCase
  def setup
    @localjob = queue
    @localjob.queue = Localjob::SysvAdapter.new(0xDEADC0DE)
  end

  def teardown
    @localjob.destroy
  end

  def test_send_and_receive
    msg = "Hello World"
    @localjob << msg
    assert_equal msg, @localjob.shift
  end

  def test_size
    @localjob << "Hello World"
    assert_equal 1, @localjob.size
  end

  def test_stats
    @localjob << "Hello World"
    assert_equal 20, @localjob.stats[:size]
    assert_equal 1,  @localjob.stats[:count]
  end

  def test_multiple_destroys_do_not_raise_exception
    @localjob.destroy
    @localjob.destroy
  end
end
