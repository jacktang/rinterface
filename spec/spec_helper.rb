$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rinterface'
require 'spec'
require 'spec/autorun'
module RinterfaceMatchers
  class BeOk

    def initialize(expect=nil)
      @expect = expect
    end

    def matches?(actual)
      code, @actual = actual
      cc = code == :ok
      @expect ? (@actual == @expect && cc) : cc
    end

    def failure_message;          "expected #{@expect} but received #{@actual.inspect}";    end
    def negative_failure_message; "expected something else then '#{@expect}' but got '#{@actual}'";    end
  end

  def be_ok;    BeOk.new;  end

  def be_ok_with(v)
    BeOk.new(v)
  end
end

Spec::Runner.configure do |config|
  config.include RinterfaceMatchers
end

