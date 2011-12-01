require 'benchmark'
require 'lib/rinterface'


# Try different responses...

puts "Bad rpc test. Try to call the wrong service"
r = Erlang::Node.rpc("math","matx_server","add",[10,20])
puts "Got: #{r.inspect}"

puts "--------"
puts "Bad port test, No Port for Service. Can't find a port for 'ath'"
r = Erlang::Node.rpc("ath","matx_server","add",[10,20])
puts "Got: #{r.inspect}"

puts "--------"
puts "Good call, add 10 + 20"
r = Erlang::Node.rpc("math","math_server","add",[10,20])
puts "Got: #{r.inspect}"

puts "-------"
puts "Benchmarks"
n = 1000
Benchmark.bm do |x|
  x.report do 
    for i in 1..n;
      a = rand(i)
      b = rand(n)
      r = Erlang::Node.rpc("math","math_server","add",[a,b])
    end 
 end
end

