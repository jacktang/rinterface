rinterface
==========

Pure Ruby client that can send RPC calls to an Erlang node.
_It's very much a work in progress._

__License:__ MIT ?


## Install

    gem install rinterface


## Try it out

Open a terminal and run:

    rake run

This will start the erlang node named 'math'.

Open another terminal, and run:

    ruby examples/client.rb


## How to use?

In your Ruby code, make a call to the Erlang node like this:

Erlang::Node(nodename,module,function,args) => [:ok,Response] | [:badprc,Reason]


    r = Erlang::Node.rpc("math","math_server","add",[10,20])

    if r[0] == :badrpc
      puts "Got and Error. Reason #{r[1]}"
    else
      puts "Success: #{r[1]}"
    end

Where:

*  math is the node name (the -sname of the Erlang node)
*  math_server is the name of the module
*  add is the funtion to call
*  [10,20] is an array of arguments to pass to the function

The result will always be an Array of the form:

    [:ok, response]

Where Response is the result from the Erlang, or:

    [:badrpc, reason]

Where Reason is the 'why' it failed.

### Experimental new way

The code above can be written like this now:

    Erl::MathServer.add(10, 20)
		
(Ain`t Ruby a beauty? ;)


### So you wanna test your Erlang code from RSpec...

Here's a quick and simple example. Make sure you put the rinterface lib into RAILS_ROOT/lib and start the math_server in 'test'



### So you wanna call Erlang from your Rails app...

Here's a quick and simple example. Make sure you put the rinterface lib into RAILS_ROOT/lib and start the math_server in 'test'
In the controller:

    controllers/math_controller.rb

    require "lib/rinterface"

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


Finally, add a template for the view, and try 'http://localhost:3000/math?a=2&b=3'.
This is not ideal yet and not something I'd use yet in production,
but it's a starting point for experimenting.


## Specs

Don`t forget to run specs before/after patching.

Use either "rake spec" or "spec spec",
it`ll start the erlang daemon automatically.
