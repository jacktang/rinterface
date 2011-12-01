RInterface
==========

Pure Ruby client that can send RPC calls to an Erlang node. _It's very much a work in progress._

__License:__ MIT License


## Play it

* Clone the project and enter the project directory and compile the project
  <pre>
	git clone https://github.com/jacktang/rinterface.git`
	cd rinterface; rake;
  </pre> 
* In one terminal run the command:
  <pre>
    rake daemon:start
  </pre> This will start the erlang node named 'math'.

* Open another terminal, and run the rpc-call from client:
  <pre>
    ruby examples/client.rb
  </pre>

## Install it  

 TODO


## Use in Ruby app

In your Ruby code, make a call to the Erlang node like this:
<pre>
    r = Erlang::Node.rpc("math","math_server","add",[10,20])

    if r[0] == :badrpc
      puts "Got and Error. Reason #{r[1]}"
    else
      puts "Success: #{r[1]}"
    end
</pre>
Where:

*  math is the node name (the -sname of the Erlang node)
*  math_server is the name of the module
*  add is the funtion to call
*  [10,20] is an array of arguments to pass to the function

The result will always be an Array of the form:
<pre>
    [:ok, Response]
</pre>
Where Response is the result from the Erlang, or:
<pre>
    [:badrpc, Reason]
</pre>
Where Reason is the 'why' it failed.

### Experimental new way

The code above can be written like this now:

    Erl::MathServer.add(10, 20)

(Ain`t Ruby a beauty? ;)

## Use in Rails app

Here's a quick and simple example. Make sure you put the rinterface lib into RAILS_ROOT/lib and start the math_server in 'test'
In the controller(controllers/math_controller.rb):
<pre>
    require "rinterface"
    class MathController < ApplicationController
      def index
        a = params[:a]
        b = params[:b]
        r = Erlang::Node.rpc("math","math_server","add",[a.to_i,b.to_i])
        if r[0] == :badrpc
          @result = "Error"
        else
          @result = r[1]
        end
      end
    end
</pre>

Finally, add a template for the view, and try 'http://localhost:3000/math?a=2&b=3'.
This is not ideal yet and not something I'd use yet in production,
but it's a starting point for experimenting.

## Development Plan

* Adopt BERT as decoder/encoder


## Contribute to the project

* Fork the project
* Improve the code or add your idea
* Run specs before/after patching. Use either "rake spec" or "spec spec", it`ll start the erlang daemon automatically.
* Send me the pull request on Github


## Other stuff

* http://code.google.com/p/a2800276/source/browse/trunk/ruby/erlang/lib
* http://code.google.com/p/erlectricity/source/browse/#svn/trunk/lib/erlectricity
