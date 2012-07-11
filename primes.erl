-module(primes).
-export([sprimes/1, wheel/3, fprimes/1, filter/2, output/0, write/0]).    

sieve([H|T], M) when H=< M -> [H|sieve([X || X<- T, X rem H /= 0], M)];
sieve(L, _) -> L.
sprimes(N) -> [2,3,5,7|sieve(wheel(11, [2,4,2,4,6,2,6,4,2,4,6,6,2,6,4,2,6,4,6,8,4,2,4,2,4,8,6,4,6,2,4,6,2,6,6,4,2,4,6,2,6,4,2,4,2,10,2,10], N), math:sqrt(N))].

wheel([X|Xs], _Js, M) when X > M ->
    lists:reverse(Xs);
wheel([X|Xs], [J|Js], M) ->
    wheel([X+J,X|Xs], lazy:next(Js), M);
wheel(S, Js, M) ->
    wheel([S], lazy:lazy(Js), M).

fprimes(N) ->
    fprimes(wheel(11, [2,4,2,4,6,2,6,4,2,4,6,6,2,6,4,2,6,4,6,8,4,2,4,2,4,8,6,4,6,2,4,6,2,6,6,4,2,4,6,2,6,4,2,4,2,10,2,10], N), [7,5,3,2], N).
fprimes([H|T], A, Max) when H*H =< Max ->
    fprimes(filter(H, T), [H|A], Max);
fprimes(L, A, _Max) -> lists:append(lists:reverse(A), L).

filter(N, L) ->
    filter(N, N*N, L, []).
filter(N, N2, [X|Xs], A) when X < N2 ->
    filter(N, N2, Xs, [X|A]);
filter(N, _N2, L, A) ->
    filter(N, L, A).
filter(N, [X|Xs], A) when X rem N /= 0 ->
    filter(N, Xs, [X|A]);
filter(N, [_X|Xs], A) ->
    filter(N, Xs, A);
filter(_N, [], A) ->
    lists:reverse(A).

output() ->
    A = now(),
    sprimes(1000000),
    io:format("Simulation Time is~p ms ~n", [timer:now_diff(now(),A)/1000]). 

write() ->
    L = primes:sprimes(1000000),
    file:write_file("home", io_lib:fwrite("~p.\n", [L])). 

