-module(prime_1).
-compile(export_all).

lazy(L) ->
    repeat(L).

repeat(L) -> L++[fun() -> L end].

next([F]) -> F()++[F];
next(L) -> L.

prime([H|T], M) when H=< M -> [H|prime([X || X<- T, X rem H /= 0], M)];
prime(L, _) -> L.
sprimes(N) -> [2,3,5,7|prime(wheel(11, [2,4,2,4,6,2,6,4,2,4,6,6,2,6,4,2,6,4,6,8,4,2,4,2,4,8,6,4,6,2,4,6,2,6,6,4,2,4,6,2,6,4,2,4,2,10,2,10], N), math:sqrt(N))].

wheel([X|Xs], _Js, M) when X > M ->
    lists:reverse(Xs);
wheel([X|Xs], [J|Js], M) ->
    wheel([X+J,X|Xs], lazy:next(Js), M);
wheel(S, Js, M) ->
    wheel([S], lazy:lazy(Js), M).

output() ->
    A = now(),
    sprimes(1000000),
    io:format("Simulation Time is~p ms ~n", [timer:now_diff(now(),A)/1000]). 

write() ->
    L = primes:sprimes(1000000),
    file:write_file("home", io_lib:fwrite("~p.\n", [L])). 

