% Arquivo: odd_even.pl
% Exercício 21.1 - Learning odd and even predicates

:- [mini_hyper].

% Background knowledge
backliteral(even(L), [L]):- !.
backliteral(odd(L), [L]):- !.
backliteral(term(list, [X|L], [X|L]), [L]):- !.
backliteral(term(list, [], []), []):- !.

% Prolog predicates
prolog_predicate(term(_, _, _)).
% Starting clauses for odd and even
start_clause([odd(L)] / [L]).
start_clause([even(L)] / [L]).

% Examples for odd length lists
ex(odd([a])).
ex(odd([b,c,d])).
ex(odd([a,b,c,d,e])).

% Examples for even length lists
ex(even([])).
ex(even([a,b])).
ex(even([a,b,c,d])).

% Negative examples
nex(even([a])).
nex(even([a,b,c])).
nex(odd([])).
nex(odd([a,b])).
nex(odd([a,b,c,d])).

% Start hypothesis
start_hyp(Hyp):-
    findall(Clause/Vars,
            start_clause(Clause/Vars),
            Hyp).

:- dynamic max_proof_length/1, max_clause_length/1.

% Run the learning process
run_learning:-
    write('Starting learning process...'), nl,
    retractall(max_proof_length(_)),
    retractall(max_clause_length(_)),
    assert(max_proof_length(10)),
    assert(max_clause_length(3)),
    statistics(runtime, [Start|_]),
    induce(Hyp),
    statistics(runtime, [End|_]),
    Time is End - Start,
    write('Learning completed in '), write(Time), write(' ms'), nl,
    write('Final hypothesis:'), nl,
    print_hypothesis(Hyp).

print_hypothesis([]).
print_hypothesis([Clause/Vars|Rest]):-
    write(Clause), write(' / '), write(Vars), nl,
    print_hypothesis(Rest).