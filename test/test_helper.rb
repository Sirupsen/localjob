require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
$:<< File.dirname(__FILE__) + "/../lib"
require 'localjob'
require "mocha/setup"
require 'jobs'

class LocaljobTestCase < MiniTest::Test
  protected
  # This is a method to make sure the logger is set right.
  def worker(queue)
    Localjob::Worker.new(queue, logger: logger)
  end

  # This is a method to make sure all queues are registred and destroyed after
  # each teach run.
  def queue(name = 0x10CA110B)
    @queues ||= []
    queue = Localjob.new(name)
    @queues << queue
    queue
  end

  def teardown
    clear_queues
  end

  def logger
    @logger ||= Logger.new(ENV["DEBUG"] ? STDOUT : "/dev/null")
  end

  def clear_queues
    @queues.each(&:destroy) if @queues
  end
end
