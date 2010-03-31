-module(spec_server).
-export([start/0, power/1, echo/1, dump/1, add/2, area/1, distance/2]).

start()   -> ok.

echo(R)  -> R.

add(X, Y) -> X + Y.

power(P)  -> P * P.

dump(W)   -> io:format("Received ~p~n", [W]).

area({sqr, S})    -> S * S;
area({ret, W, H}) -> W * H;
area({circ, R})   ->
    io:format("Area received: ~p~n", [R]),
    Result = 3.14159 * R * R,
    io:format("Result ~p~n", [Result]),
    Result.

distance(P1, P2) ->
    io:format("Distance received: ~p, ~p~n", [P1, P2]),
    {X1, Y1} = P1,
    {X2, Y2} = P2,
    Result = math:sqrt(math:pow(X2 - X1, 2) + math:pow(Y2 - Y1, 2)),
    io:format("Result: ~p~n", [Result]),
    Result.

