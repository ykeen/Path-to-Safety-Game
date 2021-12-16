dim(4,4).
start([1,0]).
end([2,2]).
bomb([0,1]).
bomb([1,2]).
bomb([2,0]).
bomb([3,0]).
star([2,1]).
star([2,3]).
star([3,2]).

%move Left
move([I,J],[I,NJ],left):-
NJ is J-1,
NJ < 4,
NJ >= 0.

%move Dwon
move([I,J],[NI,J],dwon):-
NI is I+1,
NI < 4 ,
NI >= 0.

%move Right
move([I,J],[I,NJ],right):-
NJ is J+1,
NJ < 4,
NJ >= 0.

%move Up
move([I,J],[NI,J],up):-
NI is I-1,
NI < 4,
NI >= 0.

append([],L,[L]).
append(L, [], L).
append([H|T], L2, [H|NT]):- 
append(T, L2, NT). 

unsafe([I,J]):-
bomb([BI,MI]),
compare(=,BI ,I),
compare(=,MI ,J).

play(Moves,Stars):-
  start(X),
  game(X,[X],[],Moves,Stars).

count_star([],I,I).
count_star([H|T],I,R):-
(is_star(H)-> 
Rn is I+1,
count_star(T,Rn,R)
;
count_star(T,I,R)).

 is_star(L):-
 star(X),
 compare(=,X,L).

game([2,2],Visited,M3,M3,S3):-
count_star(Visited,0,S3).

game(State,Visited,M,M2,S2):-
move(State,Next,Seq), 
\+ unsafe(Next),
\+ member(Next,Visited),
append(M,Seq,M3),
game(Next,[Next|Visited],M3,M2,S2).