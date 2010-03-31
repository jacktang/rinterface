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


# Hack-ish
module Daemon
  NAME = "spec_server"
  COMM = "erl -noshell -W -pa spec -sname spec -s #{NAME}&"

  def self.start!
    if is_running?
      puts "Spec daemon running. (PID #{@pid})"
    else
      puts "Starting daemon.."
      system("rake spec:run")#erl -noshell -W -pa spec -sname spec -s spec_server&")
      sleep 1
      start!
    end
  end

  def self.is_running?
    # Avoids grep from greping itself
    n2, n1 = NAME[-1].chr, NAME.chop
    if pid = `ps x | grep #{n1}[#{n2}]`.split(/\s/)[1]
      @pid = pid.to_i
    else
      false
    end
  end
end

puts Daemon.start!

Spec::Runner.configure do |config|
  config.include RinterfaceMatchers
end

