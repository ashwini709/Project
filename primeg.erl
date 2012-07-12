%compilation time is 9 seconds for prime numbers upto 1 million
%Use only 1 core

-module(primeg).
-compile(export_all).

%To check for prime number N, by dividing it till sqrt(N) 
%with a starting divisor V=2

is_prime(N,V) ->
    E = round(math:sqrt(N))+1,
    case V >= E of
        true -> N;
          _  ->
                case N rem V of
                        0 -> "";           
                        _ -> is_prime(N,V+1)
                end
        end.
%leaves empty space for non-primes and return the primes
is_prime(N) ->
    is_prime(N,2).

%to check over a range for prime numbers
%Range will be given by the user
for(I, Max) -> for(I, Max, []).
for(Max, Max, []) -> [];
for(Max, Max, F ) -> [F(Max)];
for(I, Max, F) -> 
	[primeg:is_prime(I)|for(I+1, Max, F )].

%writes all the primes in the specified range in a home.txt file
write(X,Y) ->
    L = [E || E <- primeg:for(X,Y), E =/= []],
    file:write_file("home", io_lib:fwrite("~p.\n", [L])). 

%Gives the compilation time in seconds
output(X,Y) ->
    write(X,Y),
    B = now(),
    primeg:for(X,Y),
    A = now(),
    (timer:now_diff(A,B))*(0.000001).     




