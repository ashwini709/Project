%%takes longer than above codes
%uses both CPUs

-module(primes).                     
-export([prime/1,output/0]).        

prime_chk(Pid, P) ->
    receive
        N when N rem P /= 0 ->
            % In this case, the N can not be divided by P,
            % so pass it to next is_prime process
            Pid ! N;
        _N -> ok
    end,
    prime_chk(Pid, P).          

is_prime() ->
    Prime = receive P -> P end,
    io:format("~p~n", [Prime]),
    Pid = spawn(fun is_prime/0),
    prime_chk(Pid, P).          

prime(N) ->
    % create the first is_prime process
    Pid = spawn(fun is_prime/0),
    lists:map(fun(X) -> Pid ! X end, lists:seq(2, N)),
    ok. 

output() ->
    B = now(),
    L = prime(1000000),
    A = now(),
    timer:now_diff(A,B). 