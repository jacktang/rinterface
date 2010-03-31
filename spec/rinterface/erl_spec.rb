require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include Rinterface

describe Erl do

  it "should shotcut method calling" do
    Erl::SpecServer.echo("Rock").should eql([:ok, "Rock"])
  end

  it "should shotcut method calling" do
    Erl::SpecServer.power(10).should eql([:ok, 100])
  end

  it "should shotcut method calling" do
    Erl::SpecServer.add(2, 2).should be_ok_with(4)
  end

  it "should snake case" do
    Erl.snake("SpecServer").should eql("spec_server")
    Erl.snake("Fu").should eql("fu")
  end
end

