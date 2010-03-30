require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Rinterface" do

  describe "Test Erlang Spec Server" do

    it "should work with arity 1" do
      r = Erlang::Node.rpc("spec","spec_server","power", [10])
      r.should eql([:ok, 100])
    end
    
    it "should sum" do
      r = Erlang::Node.rpc("spec","spec_server","add", [10,10])
      r.should eql([:ok, 20])
    end
    
    it "should work with strings" do
      r = Erlang::Node.rpc("spec","spec_server", "dump", ["hi from ruby"])
      r.should eql([:ok, :ok])
    end
    
    it "should have a nice matcher" do
      r = Erlang::Node.rpc("spec","spec_server","add",[10,20])
      r.should be_ok
    end
    
    it "should have a nicer matcher" do
      r = Erlang::Node.rpc("spec","spec_server","add",[10,20])
      r.should be_ok_with(30)
    end
    
    it "should work with atoms {sqr, 10}" do
      r = Erlang::Node.rpc("spec","spec_server","area", {:sqr => 10})
      r.should be_ok_with(100)
    end
    
    it "should work with atoms and integers {circ, 10}" do
      r = Erlang::Node.rpc("spec","spec_server","area", {:circ => 10})
      r.should be_ok_with(314.159)
    end

    it "should work with atoms and floats {circ, 10.1}" do
      r = Erlang::Node.rpc("spec","spec_server","area", {:circ => 10.1})
      r.should be_ok_with(320.47359589999996)
    end
    
    it "should work with arrays" do
      r = Erlang::Node.rpc("spec","spec_server","distance", [[1,1],[2,2]])
      r.should be_ok_with(1.4142135623730951)
    end
    
    it "should return errors" do
      r = Erlang::Node.rpc("p","spec_server","add",[10,20])
      r.should_not be_ok
    end
  end
end
